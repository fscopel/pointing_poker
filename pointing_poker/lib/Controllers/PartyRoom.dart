import 'package:flutter/material.dart';
import 'package:pointing_poker/models/guest.dart';
import 'package:pointing_poker/ui_parts/GuestMembers.dart';
import 'package:signalr_core/signalr_core.dart';

class PartyRoom extends StatefulWidget {
  int roomNumber;
  String userName;
  HubConnection connection;

  PartyRoom(this.roomNumber, this.userName, this.connection);

  @override
  _PartyRoomState createState() =>
      _PartyRoomState(roomNumber, userName, connection);
}

class _PartyRoomState extends State<PartyRoom> {
  int roomNumber;
  String userName;
  HubConnection connection;
  List<Guest> guests = <Guest>[];

  _PartyRoomState(this.roomNumber, this.userName, this.connection);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    connection.on('ReceiveMessage', (message) {
      if (message[0] != null) {
        guests.add(Guest(message[0], 0));
        setState(() {
          guests = guests;
        });
      }
    });

    connection.invoke('SendMessage',
        args: ['$userName', 'Joined the Room', '$roomNumber']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter - Pointing Poker for the Web'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 25, top: 25),
              child: Text('Welcome to Room $roomNumber'),
            ),
            Container(
              height: 300,
              width: 300,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: guests.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${guests[index].name}'),
                            Text('${guests[index].vote}'),
                          ]),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
