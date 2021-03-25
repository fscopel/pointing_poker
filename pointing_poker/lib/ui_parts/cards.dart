import 'package:flutter/material.dart';
import 'package:pointing_poker/models/player.dart';
import 'package:signalr_core/signalr_core.dart';

class Cards extends StatefulWidget {
  Player player;
  HubConnection connection;

  Cards(this.player, this.connection);

  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  final String _showAllLabel = 'Show All';
  final String _hideAllLabel = 'Hide All';
  String _showAll;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _showAll = _showAllLabel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 125,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () => clearAll(),
                          child: Text('Reset All'))),
                  SizedBox(
                      width: 125,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () => showAll(), child: Text(_showAll))),
                ]),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                votingCard('1'),
                votingCard('2'),
                votingCard('3'),
                votingCard('5'),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                votingCard('8'),
                votingCard('13'),
                votingCard('21'),
                votingCard('?'),
              ]),
        ],
      ),
    );
  }

  Future vote(String vote) async {
    widget.player.vote = vote;
    await widget.connection
        .invoke('SetVote', args: ['${widget.player.toJson()}']);
  }

  Future clearAll() async {
    await widget.connection
        .invoke('ClearAll', args: ['${widget.player.roomNumber.toString()}']);
    _showAll = _showAllLabel;

    setState(() {
      _showAll = _showAll;
    });
  }

  Future showAll() async {
    if (_showAll == _showAllLabel) {
      _showAll = _hideAllLabel;
      await widget.connection.invoke('ShowAll',
          args: ['${widget.player.roomNumber.toString()}', true]);
    } else {
      _showAll = _showAllLabel;
      await widget.connection.invoke('ShowAll',
          args: ['${widget.player.roomNumber.toString()}', false]);
    }

    setState(() {
      _showAll = _showAll;
    });
  }

  Widget votingCard(String points) {
    return Card(
      color: Color(0xFF8455DB),
      shadowColor: Color(0xFF5F2DB6),
      child: InkWell(
        splashColor: Colors.white.withAlpha(50),
        onTap: () => vote(points),
        child: SizedBox(
          width: 75,
          height: 100,
          child: Center(
            child: Text('$points',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
