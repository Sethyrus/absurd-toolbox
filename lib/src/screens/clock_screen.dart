import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/clock/chronometer.dart';
import 'package:absurd_toolbox/src/widgets/clock/timer.dart';
import 'package:flutter/material.dart';

class ClockScreen extends StatelessWidget {
  static const String routeName = '/clock';

  const ClockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Layout(
        statusBarColor: Colors.orange,
        themeColor: Colors.orange.shade400,
        title: 'Reloj',
        tabBarItems: const [
          Tab(
            child: Text(
              'Cronómetro',
              style: TextStyle(color: Colors.black),
            ),
          ),
          Tab(
            child: Text(
              'Temporizador',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        content: const TabBarView(
          children: [
            Chronometer(),
            Timer(),
          ],
        ),
      ),
    );
  }
}
