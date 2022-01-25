import 'package:absurd_toolbox/src/models/raffle.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/_general/custom_dropdown_button.dart';
import 'package:flutter/material.dart';

class RafflesScreen extends StatefulWidget {
  static const String routeName = '/raffles';

  @override
  State<RafflesScreen> createState() => _RafflesScreenState();
}

class _RafflesScreenState extends State<RafflesScreen> {
  Raffle _selectedRaffle = raffles[0];

  List<DropdownMenuItem<Raffle>>? get _dropdownItems => raffles
      .map((r) => DropdownMenuItem(
            child: Text(r.name),
            value: r,
          ))
      .toList();

  void _onSelectRaffle(Raffle? selectedRaffle) {
    if (selectedRaffle != null)
      setState(
        () => _selectedRaffle = selectedRaffle,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.green,
      themeColor: Colors.green.shade400,
      title: 'Sorteos',
      content: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            CustomDropdownButton<Raffle>(
              items: _dropdownItems,
              onChanged: (r) => _onSelectRaffle(r),
              hint: _selectedRaffle.name,
              backgroundColor: Colors.green.shade400,
            ),
            Divider(color: Colors.grey.shade600, thickness: 2, height: 32),
            _selectedRaffle.widget,
          ],
        ),
      ),
    );
  }
}
