import 'package:card_game_sockets/utils/deck.dart';
import 'package:card_game_sockets/widgets/playingCard.dart';

List<PlayingCard> deck = buildDeck();
List playerHands = [];

void shuffleDeck() {
  deck.shuffle();
}

List dealCards(int numberOfPlayers) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < numberOfPlayers; j++) {
      playerHands[i].add(deck.removeLast());
    }
  }
  return playerHands;
}
