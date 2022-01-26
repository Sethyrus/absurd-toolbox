import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  static const String routeName = '/clock';

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.orange,
      themeColor: Colors.orange.shade400,
      title: 'Reloj',
      content: Center(
        child: Text("Reloj - En desarrollo"),
      ),
    );
  }
}
