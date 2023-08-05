import 'package:card_game_sockets/pages/game.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  bool join = false;
  @override
  Widget build(BuildContext context) {
    final String roomId = ModalRoute.of(context)!.settings.arguments as String;
    final DatabaseReference roomRef =
        FirebaseDatabase.instance.ref().child('rooms/$roomId');

    roomRef.onValue.listen((event) {
      Map<String, dynamic> data = event.snapshot.value as Map<String, dynamic>;
      setState(() {
        join = data['canJoin'];
      });
    });
    return join ? Scaffold(
        body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: double.infinity),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text('Waiting for other players to join...',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Text('RoomId: $roomId',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  ElevatedButton(
                      onPressed: () {
                        ClipboardData data = ClipboardData(text: roomId);
                        Clipboard.setData(data);
                      },
                      child: const Text('Copy Room ID'))
                ],
              )
            ): const GamePage();
  }
}
