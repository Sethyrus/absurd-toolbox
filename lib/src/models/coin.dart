enum CoinValue {
  Heads,
  Tails,
}

class Coin {
  CoinValue? coinValue;

  Coin({CoinValue? value}) {
    if (value != null) {
      coinValue = value;
    } else {
      List<CoinValue> coinValues = [CoinValue.Heads, CoinValue.Tails];
      coinValues.shuffle();
      coinValue = coinValues[0];
    }
  }
}
