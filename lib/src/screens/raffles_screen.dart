import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/raffles/raffle.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/widgets/raffles/heads_or_tails.dart';

enum RaffleMode {
  HeadsOrTails,
  Raffle,
}

class RafflesScreen extends StatefulWidget {
  static const String routeName = '/raffles';

  @override
  State<RafflesScreen> createState() => _RafflesScreenState();
}

class _RafflesScreenState extends State<RafflesScreen> {
  RaffleMode raffleMode = RaffleMode.HeadsOrTails;

  String raffleTitle() {
    switch (raffleMode) {
      case RaffleMode.HeadsOrTails:
        return "Cara o cruz";
      case RaffleMode.Raffle:
        return "Sorteo";
    }
  }

  Widget raffleWidget() {
    switch (raffleMode) {
      case RaffleMode.HeadsOrTails:
        return HeadsOrTails();
      case RaffleMode.Raffle:
        return Raffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.green,
      themeColor: Colors.green.shade400,
      showAppBar: true,
      title: 'Sorteo',
      content: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Text("Cara o cruz"),
                  value: RaffleMode.HeadsOrTails,
                ),
                DropdownMenuItem(
                  child: Text("Sorteo"),
                  value: RaffleMode.Raffle,
                ),
              ],
              onChanged: (RaffleMode? value) {
                if (value != null) {
                  setState(() {
                    raffleMode = value;
                  });
                }
              },
              hint: Text("Modo: " + raffleTitle().toLowerCase()),
            ),
            Divider(color: Colors.grey.shade600, thickness: 2, height: 32),
            raffleWidget(),
          ],
        ),
      ),
    );
  }
}
