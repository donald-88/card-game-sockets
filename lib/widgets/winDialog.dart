import 'package:flutter/material.dart';

showWinDialog(
  BuildContext context,
  String player
) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('W I N N E R ! !'),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$player won the game!'),
              ],
            ),
            actions: [
              
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Play Again"))
            ],
          ));
}
