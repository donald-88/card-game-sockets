import 'package:flutter/material.dart';

showKnockDialog(
  BuildContext context,
  String player
) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('KNOCK KNOCK!'),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$player has one card left!'),
              ],
            ),
          ));
}
