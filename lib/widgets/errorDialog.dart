import 'package:flutter/material.dart';

showErrorDialog(String title, String error, BuildContext context, ){
  showDialog(
    context: context, builder: (context) => AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
      ],
    ),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(error),
      ],
    ),
  ));
}