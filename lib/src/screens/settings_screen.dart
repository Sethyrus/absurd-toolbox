import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.indigo.shade700,
      themeStyle: ThemeStyle.Light,
      title: "Ajustes",
      themeColor: Colors.indigo.shade400,
      content: Center(),
    );
  }
}
