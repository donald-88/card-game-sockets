import 'package:card_game_sockets/models/roomModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class RoomService {
  final DatabaseReference _roomRef =
      FirebaseDatabase.instance.ref().child('rooms');

  Future<void> createRoom(String playerId, BuildContext context) async {
    const uuid = Uuid();
    String roomId = uuid.v1();
    try {
      RoomModel roomModel = RoomModel(
          roomId: roomId,
          players: [playerId],
          drawPile: [],
          discardPile: [],
          turnIndex: 0,
          canJoin: false);
      await _roomRef.child(roomId).set(roomModel.toJson());
      Navigator.pushNamed(context, '/game', arguments: roomId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> joinRoom(String playerId, String roomId) async {
    try {
      DatabaseReference roomRef = _roomRef.child(roomId);
      final snapshot = await roomRef.get();
      if (snapshot.exists) {
        RoomModel roomModel = RoomModel.fromJson(snapshot.value);
        roomModel.players.add(playerId);
        await roomRef.set(roomModel.toJson());
      } else {
        print('No data available.');
      }
    } catch (e) {
      print(e);
    }
  }
}
