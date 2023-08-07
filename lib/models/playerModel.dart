import 'package:card_game_sockets/models/cardModel.dart';

class PlayerModel {
  String playerId;
  String roomId;
  List<CardModel> hand;

  PlayerModel(
      {required this.playerId, required this.roomId, required this.hand});

  Map<String, dynamic> toJson() => {
        'playerId': playerId,
        'roomId': roomId,
        'hand': hand.map((e) => e.toJson()).toList(),
      };

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    var handObj = json['hand'] ?? [];
    return PlayerModel(
        playerId: json['playerId'],
        roomId: json['roomId'],
        hand: List<CardModel>.from(handObj.map((x) => CardModel.fromJson(x))));
  }
}
