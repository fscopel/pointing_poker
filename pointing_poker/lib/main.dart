import 'dart:math';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'Controllers/LogIn.dart';
import 'Controllers/PartyRoom.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

Future<void> main(List<String> arguments) async {
  configureApp();
  final connection = HubConnectionBuilder()
      .withUrl(
          'https://localhost:44366/chatHub',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();

  await connection.start();

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

  _MyAppState(this.connection);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pointing Poker',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter - Pointing Poker for the Web'),
        ),
        body: Container(
          color: Colors.deepPurple[100],
          child: LogIn(connection),
        ),
      ),
    );
  }
}
