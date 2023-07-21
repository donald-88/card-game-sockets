bool cardValidator(Map<String, dynamic> card, Map<String, dynamic> topCard) {
  if (card['suit'] == topCard['suit'] || card['rank'] == topCard['rank']) {
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