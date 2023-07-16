import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/roomDataProvider.dart';
import 'socketClient.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String creatorId) {
    if(creatorId.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'creatorId': creatorId});
    }
  }

  void joinRoom(String roomId, String playerId){
    if(roomId.isNotEmpty && playerId.isNotEmpty){
      _socketClient.emit('joinRoom', {
        'roomId': roomId,
        'playerId': playerId
      });
    } 
  }

  void roomCreatedListener(BuildContext context) {
    _socketClient.on('roomCreated', (room) {
      Provider.of<RoomDataProvider>(context, listen: false).updateRoomData(room);
      Navigator.pushNamed(context, '/game');
    });
  }
}