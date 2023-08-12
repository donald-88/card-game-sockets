import 'package:card_game_sockets/models/cardModel.dart';

bool cardValidator(CardModel card, CardModel topCard) {
  if (card.suit == topCard.suit || card.rank == topCard.rank || topCard.rank == 'JOKER' || card.rank == 'JOKER') {
    return true;
  }else{
    return false;
  }
}

bool checkTurn(int playerIndex, int turn) {
  turn = turn % 2;
  if (playerIndex == turn) {
    return true;
  } else {
    return false;
  }
}

bool checkAce(CardModel card) {
  if (card.rank == 'A') {
    return true;
  } else {
    return false;
  }
}