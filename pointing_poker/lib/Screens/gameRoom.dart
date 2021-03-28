import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pointing_poker/Widgets/poker_cards.dart';
import 'package:google_fonts/google_fonts.dart';

class GameRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pointing poker main room',
      home: SingleChildScrollView(
        child: Container(height: 3000, child: PlanningPoker()),
      ),
    );
  }
}

class PlanningPoker extends StatefulWidget {
  @override
  _PlanningPokerState createState() => _PlanningPokerState();
}

class _PlanningPokerState extends State<PlanningPoker> {
  Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 60),
        child: Container(
          color: Colors.blue[900],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Room number: 23453',
              style: GoogleFonts.getFont('Open Sans'),
            ),
          ),
          Wrap(children: [
            //This is the in container for the cards.
            Column(
              children: [
                Wrap(
                  children: [
                    PokerCard('1'),
                    PokerCard('2'),
                    PokerCard('3'),
                    PokerCard('5'),
                    PokerCard('8'),
                  ],
                ),
                Wrap(
                  children: [
                    PokerCard('13'),
                    PokerCard('21'),
                    PokerCard('34'),
                    PokerCard('?'),
                    PokerCard('☕'),
                  ],
                ),
              ],
            ),
            //This is the names and votes will show up
            Card(
              child: SizedBox(width: 370, height: 400),
            ),
            //Some information about the game or project
            Card(
              child: SizedBox(width: 185, height: 400),
            ),
          ])
        ],
      ),
    );
  }
}
