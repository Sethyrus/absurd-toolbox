import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Theme.of(context).primaryColorDark,
      themeColor: Theme.of(context).primaryColor,
      themeStyle: ThemeStyle.light,
      title: "Ajustes",
      content: const Center(),
    );
  }
}
