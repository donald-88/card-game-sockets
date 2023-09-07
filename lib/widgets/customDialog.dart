import 'package:card_game_sockets/widgets/dialogs.dart';
import 'package:flutter/material.dart';

showCustomDialog(
    BuildContext context, String type, String title, String content) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomDialog(
            type: type,
            title: title,
            content: content,
          ));
}
