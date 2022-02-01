import 'package:absurd_toolbox/src/models/dice.dart';
import 'package:flutter/material.dart';

class DiceRoll extends StatefulWidget {
  const DiceRoll({Key? key}) : super(key: key);

  @override
  State<DiceRoll> createState() => _DiceRollState();
}

class _DiceRollState extends State<DiceRoll> {
  Dice _dice = Dice(Dice.random);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'Tirar los dados',
            style: TextStyle(fontSize: 24),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _dice.icon,
                  size: 64,
                  color: Colors.green.shade400,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => setState(() => _dice = Dice(Dice.random)),
            child: const Text('Tirar el dado'),
          ),
        ],
      ),
    );
  }
}
