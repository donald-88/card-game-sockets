import 'package:flutter/material.dart';

showWinDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('W I N N E R ! !'),
              ],
            ),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Congratualations, you won the game!'),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Play Again"))
            ],
          ));
}
