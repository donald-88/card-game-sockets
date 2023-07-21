function shuffleDeck(deck) {
  for (let i = deck.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [deck[i], deck[j]] = [deck[j], deck[i]];
  }
  return deck;
}

function dealPlayerHands(deck, numPlayers) {
  const playerHands = Array.from({ length: numPlayers }, () => []);
  for (let i = 0; i < 4; i++) {
    for (let j = 0; j < numPlayers; j++) {
      playerHands[j].push(deck.pop());
    }
  }
  return playerHands;
}


module.exports = {
  shuffleDeck,
  dealPlayerHands
};
