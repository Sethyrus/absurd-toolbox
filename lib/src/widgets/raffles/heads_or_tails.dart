import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/models/coin.dart';

class HeadsOrTails extends StatefulWidget {
  const HeadsOrTails({Key? key}) : super(key: key);

  @override
  _HeadsOrTailsState createState() => _HeadsOrTailsState();
}

class _HeadsOrTailsState extends State<HeadsOrTails> {
  Coin _coin = Coin(Coin.random);

  String get headOrTailImage {
    switch (_coin.value) {
      case CoinValue.heads:
        return 'lib/src/assets/images/coin_head.png';
      case CoinValue.tails:
        return 'lib/src/assets/images/coin_tail.png';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Cara o cruz',
            style: TextStyle(fontSize: 24),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Image(
              height: 140,
              image: AssetImage(headOrTailImage),
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => _coin = Coin(Coin.random)),
            child: const Text('Tirar la moneda'),
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
