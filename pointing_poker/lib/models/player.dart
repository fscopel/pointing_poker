import 'dart:core';
import 'dart:math';

class Player {
  int guestId;
  String name;
  int roomNumber;
  String vote;
  bool isVisible;

  Player(this.name, this.roomNumber, this.guestId, this.vote, this.isVisible);

  Player.create(this.name, this.roomNumber) {
    int min = 100000000;
    int max = 999999999;
    var random = new Random();
    this.guestId = min + random.nextInt(max - min);
    this.vote = '0';
    this.isVisible = false;
  }

  Player.fromJson(Map<String, dynamic> map) {
    this.guestId = map['guestId'];
    this.name = map['name'];
    this.roomNumber = map['roomNumber'];
    this.vote = map['vote'];
    this.isVisible = map['isVisible'];
  }

  String toJson() {
    return '{"guestId":"$guestId", "name":"$name","roomNumber":"$roomNumber","vote":"$vote","isVisible":"$isVisible"}';
  }
}
