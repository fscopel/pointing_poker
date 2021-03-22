import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/io_client.dart';

Future<void> main(List<String> arguments) async {
  final connection = HubConnectionBuilder()
      .withUrl(
          'https://localhost:44366/chatHub',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();

  await connection.start();

  connection.on('ReceiveMessage', (message) {
    print(message.toString());
  });

  //await connection.invoke('SendMessage', args: ['Fabio', '5', '23456']);

  runApp(MyApp(connection));
}

class MyApp extends StatefulWidget {
  HubConnection connection;

  MyApp(this.connection);

  @override
  _MyAppState createState() => _MyAppState(connection);
}

class _MyAppState extends State<MyApp> {
  HubConnection connection;
  TextEditingController txtName;
  TextEditingController txtNumberInParty;

  _MyAppState(this.connection);

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtNumberInParty = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pointing Poker',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter - Pointing Poker for the Web'),
        ),
        drawer: Drawer(),
        drawerEnableOpenDragGesture: false,
        body: Container(
          color: Colors.deepPurple[100],
          child: logIn(),
        ),
      ),
    );
  }

  Widget logIn() {
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
      await widget.connection
          .invoke('JoinRoom', args: [txtName.text, txtNumberInParty.text]);
    } else {
      //TODO: Handle other connection states here;
    }
  }

  Future<void> StartNewParty() async {
    int min = 100000; //min and max values act as your 6 digit range
    int max = 999999;
    var random = new Random();
    var rNum = min + random.nextInt(max - min);

    if (widget.connection.state == HubConnectionState.connected &&
        txtName.text != "") {
      await widget.connection
          .invoke('JoinRoom', args: [txtName.text, rNum.toString()]);
    } else {
      //TODO: Handle other connection states here;
    }
  }
}
