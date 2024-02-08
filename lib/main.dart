import 'package:flutter/material.dart';
import 'package:spotifyxapp/screen/Maintab.dart';
import 'package:spotifyxapp/screen/Splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spotifyxapp/mobx/ControllerStore.dart';
// import 'package:spotifyxapp/screen/LoginSpotify.dart';

final controllerstore = ControllerStore(); // Instantiate the store

void main() {
  // await dotenv.load(fileName: "env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpotifyXApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/Maintab',
      routes: {
        '/': (context) => Splash(), // Add the Sapaad screen route
        '/Maintab': (context) => Maintab(),
        // '/LoginSpotify': (context) => LoginSpotify(htmlContent: '')
      },
    );
  }
}
