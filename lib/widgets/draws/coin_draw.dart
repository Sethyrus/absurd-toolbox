import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/coin.dart';

class CoinDraw extends StatefulWidget {
  CoinDraw({Key? key}) : super(key: key);

  @override
  _CoinDrawState createState() => _CoinDrawState();
}

class _CoinDrawState extends State<CoinDraw> {
  Coin _coin = Coin();

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
              image: AssetImage(_coin.coinValue == CoinValue.heads
                  ? 'lib/assets/images/coin_head.png'
                  : 'lib/assets/images/coin_tail.png'),
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
