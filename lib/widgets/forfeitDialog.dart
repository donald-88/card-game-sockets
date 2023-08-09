import 'package:flutter/material.dart';

showForfeitDialog(BuildContext context, ){
  showDialog(context: context, builder: (context) => AlertDialog(
    title: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('FORFEIT!'),
      ],
    ),
    content: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Are you sure you want to forfeit the match?'),
      ],
    ),
    actions: [
      ElevatedButton(onPressed: (){ Navigator.of(context).pop(); Navigator.of(context).pop();}, child: const Text("Yes")),
      ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel"))
    ],
  ));
}