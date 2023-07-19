class CardModel{
  final String suit;
  final String rank;

  CardModel({
    required this.suit,
    required this.rank,
  });

  // Factory method to create a Card object from a JSON map
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      suit: json['suit'] as String,
      rank: json['rank'] as String,
    );
  }
}