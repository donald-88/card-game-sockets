import 'package:flutter/material.dart';

Future<dynamic> Loading(context) {
    return showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
  }