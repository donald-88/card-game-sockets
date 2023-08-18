import 'package:flutter/material.dart';

showPausedDialog(BuildContext context, String roomId, Widget timer, Function() onResume) {
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
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                timer
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: onResume,
                  child: const Text("Resume"))
            ],
          ));
}
