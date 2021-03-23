import 'package:flutter/material.dart';
import 'package:pointing_poker/models/player.dart';
import 'package:signalr_core/signalr_core.dart';

class Cards extends StatelessWidget {
  Player player;
  HubConnection connection;

  Cards(this.player, this.connection);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text('Show All'))),
              SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () => clearAll(), child: Text('Clear All'))),
            ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          votingCard('1'),
          votingCard('2'),
          votingCard('3'),
          votingCard('5'),
          votingCard('8'),
          votingCard('13'),
          votingCard('21'),
        ]),
      ],
    );
  }

  Future vote(String vote) async {
    player.vote = int.parse(vote);
    await connection.invoke('SetVote', args: ['${player.toJson()}']);
  }

  Future clearAll() async {
    await connection
        .invoke('ClearAll', args: ['${player.roomNumber.toString()}']);
  }

  Widget votingCard(String points) {
    return Card(
      color: Colors.lightBlueAccent,
      shadowColor: Colors.lightBlue,
      child: InkWell(
        splashColor: Colors.red.withAlpha(30),
        onTap: () => vote(points),
        child: SizedBox(
          width: 100,
          height: 150,
          child: Center(
            child: Text('$points',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
