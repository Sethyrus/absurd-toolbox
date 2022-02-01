import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum DiceValue {
  d1,
  d2,
  d3,
  d4,
  d5,
  d6,
}

class Dice {
  final DiceValue value;

  Dice(this.value);

  IconData get icon => Dice.iconFromValue(value);

  static DiceValue get random => ([
        DiceValue.d1,
        DiceValue.d2,
        DiceValue.d3,
        DiceValue.d4,
        DiceValue.d5,
        DiceValue.d6,
      ]..shuffle())[0];

  static IconData iconFromValue(DiceValue value) {
    switch (value) {
      case DiceValue.d1:
        {
          return MdiIcons.dice1;
        }
      case DiceValue.d2:
        {
          return MdiIcons.dice2;
        }
      case DiceValue.d3:
        {
          return MdiIcons.dice3;
        }
      case DiceValue.d4:
        {
          return MdiIcons.dice4;
        }
      case DiceValue.d5:
        {
          return MdiIcons.dice5;
        }
      case DiceValue.d6:
        {
          return MdiIcons.dice6;
        }
    }
  }
}
