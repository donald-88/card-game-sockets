
import 'package:card_game_sockets/models/cardModel.dart';

class RoomModel {
  String roomId;
  List<Map<String, dynamic>> players;
  int turnIndex;
  List<CardModel> drawPile;
  List<CardModel> discardPile;
  bool canJoin;

  RoomModel(
      {required this.roomId,
      required this.players,
      required this.turnIndex,
      required this.drawPile,
      required this.discardPile,
      required this.canJoin});

  Map<String, dynamic> toJson() => {
        'roomId': roomId,
        'players': players,
        'turnIndex': turnIndex,
        'drawPile': drawPile.map((e) => e.toJson()).toList(),
        'discardPile': discardPile.map((e) => e.toJson()).toList(),
        'canJoin': canJoin
      };

  factory RoomModel.fromJson(Map<String, dynamic> json){
      var playerObj = json['players'];
      var drawPileObj = json['drawPile'] ?? [];
      var discardPileObj = json['discardPile'] ?? [];
      return RoomModel(roomId : json['roomId'],
        players : List<Map<String, dynamic>>.from(playerObj),
        turnIndex : json['turnIndex'],
        drawPile : List<CardModel>.from(drawPileObj),
        discardPile : List<CardModel>.from(discardPileObj),
        canJoin : json['canJoin']);
  }
}
