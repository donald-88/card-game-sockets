import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/cardModel.dart';
import '../models/playerModel.dart';
import '../models/roomModel.dart';

class GameStateProvider extends ChangeNotifier{
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('rooms');

  List<CardModel> discardPile = [];
  int turn = 0;
  bool isPlayer1Turn = true;
  bool winner = false;
  String playerWon = '';
  bool isPaused = false;
  String playerPauseId = '';
  PlayerModel player1 = PlayerModel(
      playerId: '',
      roomId: '',
      username: '',
      avatar: '',
      knock: false,
      pauseCount: 2,
      isturn: false,
      hand: []);
  PlayerModel player2 = PlayerModel(
      playerId: '',
      roomId: '',
      username: '',
      avatar: '',
      knock: false,
      pauseCount: 2,
      isturn: false,
      hand: []);

  GameStateProvider(){
    initializeGameState();
  }

  void initializeGameState(){
    _databaseReference.child(roomId).onValue.listen((event) {
      Map<String, dynamic> room = event.snapshot.value as Map<String, dynamic>;
      RoomModel roomModel = RoomModel.fromJson(room);
      player1 = PlayerModel.fromJson(roomModel.players[0]);
      player2 = PlayerModel.fromJson(roomModel.players[1]);
      discardPile = roomModel.discardPile;
      turn = roomModel.turnIndex;
      winner = roomModel.isWon;
      playerWon = roomModel.playerWon;
      isPaused = roomModel.isPaused;
      playerPauseId = roomModel.playerPauseId;
     });
  }
}