import 'package:card_game_sockets/widgets/dialogs.dart';
import 'package:flutter/material.dart';

showKnockDialog(BuildContext context, String player) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return CustomDialog(
            type: '',
            title: 'K N O C K ! !',
            content: '$player has 1 card left.');
      });
}
