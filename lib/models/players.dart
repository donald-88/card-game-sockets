class Player {
  String playerId;
  String roomId;

  Player({required this.playerId, required this.roomId});

  Map<String, dynamic> toMap() => {
        'playerId': playerId,
        'roomId': roomId,
      };

  factory Player.fromMap(Map<String, dynamic> map) => Player(
        playerId: map['playerId'],
        roomId: map['roomId'],
      );
}
