import 'package:flutter/material.dart';
import 'package:pointing_poker/Widgets/poker_cards.dart';

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
          color: Colors.lightBlueAccent,
        ),
      ),
      body: Center(
          child: Container(
        color: Colors.amber,
        width: 1850,
        child: Column(
          children: [
            Text('Room number: 23453'),
            Wrap(children: [
              //This is the in container for the cards.
              Container(
                  color: Color(0xFFEFEFEF),
                  width: 1115,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PokerCard('1'),
                          PokerCard('2'),
                          PokerCard('3'),
                          PokerCard('5'),
                          PokerCard('8'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PokerCard('13'),
                          PokerCard('21'),
                          PokerCard('34'),
                          PokerCard('?'),
                          PokerCard('☕'),
                        ],
                      ),
                    ],
                  )),
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
      )),
    );
  }
}
