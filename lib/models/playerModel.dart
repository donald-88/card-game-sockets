import 'package:card_game_sockets/models/cardModel.dart';

class PlayerModel {
  String playerId;
  String roomId;
  bool knock;
  int pauseCount;
  bool isturn;
  List<CardModel> hand;

  PlayerModel(
      {required this.playerId,
      required this.roomId,
      required this.knock,
      required this.pauseCount,
      required this.isturn,
      required this.hand});

  Map<String, dynamic> toJson() => {
        'playerId': playerId,
        'roomId': roomId,
        'knock': knock,
        'pauseCount': pauseCount,
        'isturn': isturn,
        'hand': hand.map((e) => e.toJson()).toList(),
      };

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    var handObj = json['hand'] ?? [];
    return PlayerModel(
        playerId: json['playerId'],
        roomId: json['roomId'],
        knock: json['knock'],
        pauseCount: json['pauseCount'],
        isturn: json['isturn'],
        hand: List<CardModel>.from(handObj.map((x) => CardModel.fromJson(x))));
  }
}
