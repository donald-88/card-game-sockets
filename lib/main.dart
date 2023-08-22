import 'package:card_game_sockets/pages/authentication/authGate.dart';
import 'package:card_game_sockets/pages/lobby.dart';
import 'package:card_game_sockets/widgets/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/waitingLobby.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green, brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const AuthGate(),
        routes: {
          '/menu':(context) => const Menu(),
          '/lobby': (context) => const Lobby(),
          '/waitingLobby': (context) => const WaitingLobby(),
        },
    );
  }
}
