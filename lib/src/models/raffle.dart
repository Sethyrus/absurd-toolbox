import 'package:absurd_toolbox/src/widgets/raffles/dice.dart';
import 'package:absurd_toolbox/src/widgets/raffles/heads_or_tails.dart';
import 'package:absurd_toolbox/src/widgets/raffles/lottery.dart';
import 'package:flutter/material.dart';

enum RaffleMode {
  HeadsOrTails,
  Lottery,
  DiceRoll,
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

final List<Raffle> raffles = [
  Raffle(
    mode: RaffleMode.HeadsOrTails,
    name: "Cara o cruz",
    widget: HeadsOrTails(),
  ),
  Raffle(
    mode: RaffleMode.Lottery,
    name: "Sorteo",
    widget: Lottery(),
  ),
  Raffle(
    mode: RaffleMode.DiceRoll,
    name: "Dados",
    widget: DiceRoll(),
  ),
];
