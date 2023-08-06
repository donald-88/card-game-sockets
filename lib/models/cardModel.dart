class CardModel {
  final String suit;
  final String rank;

  CardModel({
    required this.suit,
    required this.rank,
  });

  Map<String, dynamic> toJson() => {
        'suit': suit,
        'rank': rank,
      };

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      suit: json['suit'],
      rank: json['rank'],
    );
  }
}
