import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/models/coin.dart';

class HeadsOrTails extends StatefulWidget {
  @override
  _HeadsOrTailsState createState() => _HeadsOrTailsState();
}

class _HeadsOrTailsState extends State<HeadsOrTails> {
  Coin _coin = Coin();

  String headOrTailImage() {
    switch (_coin.coinValue!) {
      case CoinValue.Heads:
        return 'lib/src/assets/images/coin_head.png';
      case CoinValue.Tails:
        return 'lib/src/assets/images/coin_tail.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Cara o cruz',
            style: TextStyle(fontSize: 24),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Image(
              height: 140,
              image: AssetImage(headOrTailImage()),
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => _coin = Coin()),
            child: Text('Tirar la moneda'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green.shade400),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
