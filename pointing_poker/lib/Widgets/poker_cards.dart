import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

enum PokerType { Fibonacci, ModifiedFibonacci }

class PokerCard extends StatefulWidget {
  String cardValue;

  PokerCard(this.cardValue);

  @override
  _PokerCardState createState() => _PokerCardState();
}

class _PokerCardState extends State<PokerCard> {
  double cardWidth;
  TextStyle fontStyle, largeFont;
  BoxShadow _boxShadow;
  bool isSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardWidth = 100;
    fontStyle = GoogleFonts.getFont('Open Sans');
    largeFont = GoogleFonts.getFont('Open Sans', fontSize: 40);
    _boxShadow = BoxShadow(
      offset: const Offset(3.0, 3.0),
      blurRadius: 5.0,
    );
    isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(children: [
        InkWell(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          onHover: (value) {
            setState(() {
              if (value == true) {
                _boxShadow = BoxShadow(
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 10.0,
                );
              } else {
                _boxShadow = BoxShadow(
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 5.0,
                );
              }
            });
          },
          child: Container(
            width: cardWidth,
            height: cardWidth * 1.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isSelected ? Colors.lightBlueAccent : Colors.white,
                boxShadow: [_boxShadow]),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cardValue,
                        style: fontStyle,
                      ),
                      Text(
                        widget.cardValue,
                        style: fontStyle,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black),
                        color:
                            isSelected ? Colors.lightBlueAccent : Colors.white,
                      ),
                      child: Center(
                          child: Text(
                        widget.cardValue,
                        style: largeFont,
                      ))),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.cardValue,
                        style: fontStyle,
                      ),
                      Text(
                        widget.cardValue,
                        style: fontStyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
