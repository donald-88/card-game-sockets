import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:flutter/material.dart';

showPausedDialog(BuildContext context, String roomId) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('G A M E  P A U S E D'),
              ],
            ),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('The game was paused. Wait for 1 minute to resume')
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    onGameResume(roomId);
                    Navigator.pop(context);
                  },
                  child: const Text("Resume"))
            ],
          ));
}
