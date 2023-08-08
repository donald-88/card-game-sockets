import 'package:flutter/material.dart';

showErrorDialog(String title, String error, BuildContext context, ){
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text(title),
    content: Text(error),
  ));
}