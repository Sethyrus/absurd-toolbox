enum CoinValue {
  Heads,
  Tails,
}

class Coin {
  final CoinValue value;

  Coin(this.value);

  static CoinValue get random => ([
        CoinValue.Heads,
        CoinValue.Tails,
      ]..shuffle())[0];
}
