enum CoinValue {
  heads,
  tails,
}

class Coin {
  final CoinValue value;

  Coin(this.value);

  static CoinValue get random => ([
        CoinValue.heads,
        CoinValue.tails,
      ]..shuffle())[0];
}
