import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class RoomService {
  final DatabaseReference _roomRef =
      FirebaseDatabase.instance.ref().child('rooms');

  Future<void> createRoom(String playerId, BuildContext context) async {
    try {
      const uuid = Uuid();
      String roomId = uuid.v1();
      await _roomRef.child(roomId).set({
        "players": [playerId],
        "turnIndex": 0,
        "drawPile": [],
        "discardPile": [],
        "canJoin": true
      });
      Navigator.pushNamed(context, '/game', arguments: {roomId});
    } catch (e) {
      print(e);
    }
  }

  Future<void> joinCreate(String player2Id) async {
    try {
      await _roomRef.set({
        "players": [player2Id]
      });
    } catch (e) {
      print(e);
    }
  }
}
