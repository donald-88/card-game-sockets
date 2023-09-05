import 'package:flutter/material.dart';

showKnockDialog(
  BuildContext context,
  String player
) {
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 1), (){
          Navigator.of(context).pop(true);
        });
        return  AlertDialog(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('KNOCK!'),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$player has one card left!'),
              ],
            ),
            
          );
      });
}