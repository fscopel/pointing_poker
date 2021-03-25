import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'Controllers/log_in.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';

Future<void> main() async {
  configureApp();
  final connection = HubConnectionBuilder()
      .withUrl(
          'https://flutterprojects.dev/server/chatHub',
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
/*      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name);
        if (uri.pathSegments.length == 2 && settings.name == '/') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(
              builder: (context) =>
                  PartyRoom(int.parse(id), 'URL Segment', connection));
        }

        return MaterialPageRoute(builder: (context) => LogIn(connection));
      },*/
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
