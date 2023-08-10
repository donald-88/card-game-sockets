import 'package:card_game_sockets/models/playerModel.dart';
import 'package:card_game_sockets/models/roomModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../utils/gameLogic.dart';

class RoomService {
  final DatabaseReference _roomRef =
      FirebaseDatabase.instance.ref().child('rooms');

  Future<void> createRoom(String playerId, BuildContext context) async {
    const uuid = Uuid();
    String roomId = uuid.v1();
    try {
      RoomModel roomModel = RoomModel(
          roomId: roomId,
          players: [],
          drawPile: [],
          discardPile: [],
          turnIndex: 0,
          canJoin: true,
          isWon: false,
          isPaused: false,
          isForfeitWin: false,
          playerWon: 'Player');

      PlayerModel playerModel = PlayerModel(
          playerId: playerId,
          roomId: roomId,
          username: '',
          knock: false,
          pauseCount: 0,
          isturn: true,
          hand: []);

      roomModel.players.add(playerModel.toJson());
      await _roomRef.child(roomId).set(roomModel.toJson());
      Navigator.pushNamed(context, '/waitingLobby', arguments: roomId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> joinRoom(
      String playerId, String roomId, BuildContext context) async {
    try {
      DatabaseReference roomRef = _roomRef.child(roomId);
      final snapshot = await roomRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> roomData = snapshot.value as Map<String, dynamic>;
        RoomModel roomModel = RoomModel.fromJson(roomData);
        roomModel.canJoin = false;
        roomModel.players.add(PlayerModel(
            playerId: playerId,
            roomId: roomId,
            username: '',
            knock: false,
            pauseCount: 0,
            isturn: true,
            hand: []).toJson());
        await roomRef.set(roomModel.toJson());

        initializeGame(roomId);
        Navigator.pushNamed(context, '/waitingLobby', arguments: roomId);
      } else {
        print('No data available.');
      }
    } catch (e) {
      print(e);
    }
  }
}
