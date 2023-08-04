class PlayerModel {
  String playerId;
  String roomId;
  List hand;

  PlayerModel({required this.playerId, required this.roomId, required this.hand});

  Map<String, dynamic> toJson() => {
        'playerId': playerId,
        'roomId': roomId,
        'hand': hand,
      };
  
  factory PlayerModel.fromJson(Map<String, dynamic> json){
      var handObj = json['hand'] ?? [];
      return PlayerModel(playerId : json['playerId'],
        roomId : json['roomId'],
        hand : List<String>.from(handObj));
  }
}
