import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'Controllers/log_in.dart';
import 'Screens/gameRoom.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

Future<void> main() async {
  configureApp();

  return runApp(GameRoom());

  final connection = HubConnectionBuilder()
      .withUrl(
          //'https://flutterprojects.dev/server/chatHub',
          'https://localhost:44366/chatHub',
          HttpConnectionOptions(
            logging: (level, message) => print(message),
          ))
      .build();

  await connection.start();

  runApp(HomeApp(connection));
}

class HomeApp extends StatefulWidget {
  HubConnection connection;

  HomeApp(this.connection);

  @override
  _HomeAppState createState() => _HomeAppState(connection);
}

class _HomeAppState extends State<HomeApp> {
  HubConnection connection;

  _HomeAppState(this.connection);

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
