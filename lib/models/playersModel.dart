class Player {
  String playerId;
  String roomId;
  List hand;

  Player({required this.playerId, required this.roomId, required this.hand});

  Map<String, dynamic> toMap() => {
        'playerId': playerId,
        'roomId': roomId,
        'hand': hand
      };

  factory Player.fromMap(Map<String, dynamic> map) => Player(
        playerId: map['playerId'] ?? '',
        roomId: map['roomId'] ?? '',
        hand: map['hand'] ?? [],
      );
}
