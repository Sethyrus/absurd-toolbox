import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinDraw extends StatelessWidget {
  const CoinDraw({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Cara'),
        ElevatedButton(
          onPressed: () {},
          child: Text('Tirar la moneda'),
        )
      ],
    );
  }
}
