import 'package:card_game_sockets/pages/game.dart';
import 'package:card_game_sockets/widgets/slideFadeInPage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({super.key});

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  bool join = true;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final String roomId = ModalRoute.of(context)!.settings.arguments as String;
    final DatabaseReference roomRef =
        FirebaseDatabase.instance.ref().child('rooms/$roomId');
    roomRef.onValue.listen((event) {
      Map<String, dynamic> data = event.snapshot.value as Map<String, dynamic>;
      if (mounted) {
        setState(() {
          join = data['canJoin'];
        });
      }
    });
    return join
        ? Scaffold(
            appBar: AppBar(),
            body: SlideFadeInPage(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text('Waiting for other players to join...',
                    textAlign: TextAlign.center,
                    style: width > 375
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 16),
                Text('RoomId: $roomId',
                    textAlign: TextAlign.center,
                    style: width > 375
                        ? Theme.of(context).textTheme.bodyLarge
                        : Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      ClipboardData data = ClipboardData(text: roomId);
                      Clipboard.setData(data);
                    },
                    child: Text('Copy Room ID',
                        style: width > 375
                            ? Theme.of(context).textTheme.labelLarge
                            : Theme.of(context).textTheme.labelMedium))
              ],
            ))
        : GamePage(
            roomId: roomId,
          );
  }
}
