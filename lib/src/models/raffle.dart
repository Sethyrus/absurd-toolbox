import 'package:flutter/material.dart';

enum RaffleMode {
  headsOrTails,
  lottery,
  diceRoll,
}

class Raffle {
  final RaffleMode mode;
  final String name;
  final Widget widget;

  Raffle({
    required this.mode,
    required this.name,
    required this.widget,
  });
}
