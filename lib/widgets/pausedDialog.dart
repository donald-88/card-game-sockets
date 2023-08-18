import 'dart:async';

import 'package:card_game_sockets/utils/gameLogic.dart';
import 'package:flutter/material.dart';

showPausedDialog(BuildContext context, StreamController<int> event, String roomId) {
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
            content: StreamBuilder<int>(
              stream: event.stream,
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('The game was paused. Wait for ${snapshot.data.toString()} seconds to resume')
                  ],
                );
              }
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
