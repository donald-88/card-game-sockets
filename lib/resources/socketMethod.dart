import 'package:flutter/material.dart';

import 'socketClient.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String creatorId) {
    if(creatorId.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'creatorId': creatorId});
    }
  }

  void roomCreatedListener(BuildContext context) {
    _socketClient.on('roomCreated', (data) {
      print(data);
      Navigator.pushNamed(context, '/game');
    });
  }
}