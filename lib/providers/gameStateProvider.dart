import 'package:card_game_sockets/models/roomModel.dart';
import 'package:flutter/material.dart';

class GameStateProvider extends ChangeNotifier {
  RoomModel _state = RoomModel(
    discardPile: [],
    playerWon: '',
    isPaused: false,
    playerPauseId: '',
    roomId: '',
    players: [],
    turnIndex: 0,
    drawPile: [],
    canJoin: true,
    isWon: false,
    isForfeitWin: false,
  );

  RoomModel get state => _state;

  void updateGameState(RoomModel newGameState) {
    _state = newGameState;
    notifyListeners();
  }
}
