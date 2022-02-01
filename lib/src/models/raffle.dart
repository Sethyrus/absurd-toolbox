import 'package:absurd_toolbox/src/widgets/raffles/dice.dart';
import 'package:absurd_toolbox/src/widgets/raffles/heads_or_tails.dart';
import 'package:absurd_toolbox/src/widgets/raffles/lottery.dart';
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

final List<Raffle> raffles = [
  Raffle(
    mode: RaffleMode.headsOrTails,
    name: "Cara o cruz",
    widget: const HeadsOrTails(),
  ),
  Raffle(
    mode: RaffleMode.lottery,
    name: "Sorteo",
    widget: const Lottery(),
  ),
  Raffle(
    mode: RaffleMode.diceRoll,
    name: "Dados",
    widget: const DiceRoll(),
  ),
];
