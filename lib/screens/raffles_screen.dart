import 'package:absurd_toolbox/models/raffle_mode.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/raffles/raffle.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/widgets/raffles/heads_or_tails.dart';

class RafflesScreen extends StatefulWidget {
  static const String routeName = '/raffles';

  @override
  State<RafflesScreen> createState() => _RafflesScreenState();
}

class _RafflesScreenState extends State<RafflesScreen> {
  RaffleMode raffleMode = RaffleMode.headsOrTails;

  String raffleTitle() {
    switch (raffleMode) {
      case RaffleMode.headsOrTails:
        return "Cara o cruz";
      case RaffleMode.raffle:
        return "Sorteo";
    }
  }

  Widget raffleWidget() {
    switch (raffleMode) {
      case RaffleMode.headsOrTails:
        return HeadsOrTails();
      case RaffleMode.raffle:
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
                  value: RaffleMode.headsOrTails,
                ),
                DropdownMenuItem(
                  child: Text("Sorteo"),
                  value: RaffleMode.raffle,
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
            Divider(color: Colors.black54, thickness: 2, height: 32),
            raffleWidget(),
          ],
        ),
      ),
    );
  }
}
