import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.indigo.shade700,
      content: Center(
        child: Text("Settings"),
      ),
    );
  }
}
