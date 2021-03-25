import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pointing_poker/Controllers/party_room.dart';
import 'package:pointing_poker/models/player.dart';
import 'package:signalr_core/signalr_core.dart';

class LogIn extends StatefulWidget {
  HubConnection connection;
  LogIn(this.connection);

  @override
  _LogInState createState() => _LogInState(connection);
}

class _LogInState extends State<LogIn> {
  TextEditingController txtName;
  TextEditingController txtNumberInParty;
  HubConnection connection;

  _LogInState(this.connection);

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtNumberInParty = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.all(Radius.circular(20))),
        width: 500,
        height: 350,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 55),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 320,
                child: TextField(
                  controller: txtName,
                  decoration: InputDecoration(
                    labelText: 'Enter your name here',
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 120,
                      width: 150,
                      child: ElevatedButton(
                          onPressed: StartNewParty,
                          child: Text('Start new party')),
                    ),
                    SizedBox(
                      height: 120,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            controller: txtNumberInParty,
                            maxLength: 6,
                            maxLines: 1,
                            decoration:
                                InputDecoration(labelText: 'Party number'),
                          ),
                          ElevatedButton(
                              onPressed: () => JoinPartyClick(),
                              child: Text('Join a party')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> JoinPartyClick() async {
    if (widget.connection.state == HubConnectionState.connected &&
        txtName.text != "" &&
        txtNumberInParty.text != "") {
      var player =
          Player.create(txtName.text, int.parse(txtNumberInParty.text));
      await widget.connection.invoke('JoinRoom', args: [player.toJson()]);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PartyRoom(player, connection)));
    } else {
      //TODO: Handle other connection states here;
    }
  }

  Future StartNewParty() async {
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var random = new Random();
    var roomNumber = min + random.nextInt(max - min);

    if (widget.connection.state == HubConnectionState.connected &&
        txtName.text != "") {
      var player = Player.create(txtName.text, roomNumber);
      await widget.connection.invoke('JoinRoom', args: [player.toJson()]);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PartyRoom(player, connection)));
    }
  }
}
