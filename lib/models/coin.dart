enum CoinValue {
  heads,
  tails,
}

class Coin {
  CoinValue? coinValue;

  Coin({CoinValue? value}) {
    if (value != null) {
      coinValue = value;
    } else {
      List<CoinValue> coinValues = [CoinValue.heads, CoinValue.tails];
      coinValues.shuffle();
      coinValue = coinValues[0];
    }
  }
}
