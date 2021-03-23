import 'package:flutter/material.dart';
import 'package:pointing_poker/models/player.dart';
import 'package:pointing_poker/ui_parts/GuestMembers.dart';
import 'package:pointing_poker/ui_parts/cards.dart';
import 'package:signalr_core/signalr_core.dart';
import "dart:convert";

class PartyRoom extends StatefulWidget {
  Player player;
  HubConnection connection;

  PartyRoom(this.player, this.connection);

  @override
  _PartyRoomState createState() => _PartyRoomState(player, connection);
}

class _PartyRoomState extends State<PartyRoom> {
  Player player;
  HubConnection connection;
  List<Player> players = <Player>[];

  _PartyRoomState(this.player, this.connection);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    connection.on('ReceiveLatestList', (message) {
      //TODO: Convert server data into List<Player>
      try {
        players.removeRange(0, players.length);

        var mappedPlayers =
            json.decode(message[0]).map((p) => Player.fromJson(p)).toList();

        for (var i = 0; i < mappedPlayers.length; i++) {
          players.add(Player(mappedPlayers[i].name, mappedPlayers[i].roomNumber,
              mappedPlayers[i].guestId, mappedPlayers[i].vote));
        }

        setState(() {
          players = players;
        });
      } catch (e) {
        print(e);
      }
    });

    connection.invoke('GetLatestList', args: ['${player.roomNumber}']);
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
              child: Text(
                '${player.name} - Welcome to Room ${player.roomNumber}',
                style: TextStyle(fontSize: 48, fontFamily: 'Helvetica'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Cards(player, connection),
            ),
            Container(
              height: 300,
              width: 300,
              child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: players.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${players[index].name}', style: textStyle),
                            Text('${players[index].vote}', style: textStyle),
                          ]),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  var textStyle = TextStyle(fontSize: 28, fontWeight: FontWeight.normal);
}
