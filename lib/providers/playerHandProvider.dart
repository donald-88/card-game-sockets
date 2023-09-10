import 'package:card_game_sockets/widgets/playingCard.dart';
import 'package:flutter/material.dart';

class PlayerHandProvider extends ChangeNotifier{
  List<PlayingCard> _playerHand = [];

  void addCard(PlayingCard card){
    _playerHand.add(card);
    notifyListeners();
  }

  void removeCard(PlayingCard card){
    _playerHand.remove(card);
    notifyListeners();
  }
}