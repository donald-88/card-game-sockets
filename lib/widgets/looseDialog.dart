import 'package:flutter/material.dart';

showLooseDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('L O S E R ! !'),
              ],
            ),
            content: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You lost the game!'),
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
