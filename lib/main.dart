import 'package:card_game_sockets/pages/authentication/authGate.dart';
import 'package:card_game_sockets/pages/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/roomDataProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme:ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const AuthGate(),
        routes: {
          '/game': (context) => const GamePage(),
        },
      ),
    );
  }
}
