import 'package:flutter/material.dart';

class DiceRoll extends StatefulWidget {
  @override
  State<DiceRoll> createState() => _DiceRollState();
}

class _DiceRollState extends State<DiceRoll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'Tirar los dados',
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
    );
  }
}
