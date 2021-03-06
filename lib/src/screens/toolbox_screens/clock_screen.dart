import 'package:absurd_toolbox/src/consts.dart';
import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:absurd_toolbox/src/widgets/clock/chronometer.dart';
import 'package:absurd_toolbox/src/widgets/clock/timer.dart';
import 'package:flutter/material.dart';

class ClockScreen extends StatelessWidget {
  static const String routeName = '/clock';

  const ClockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tool tool = tools.firstWhere((t) => t.route == ClockScreen.routeName);

    return DefaultTabController(
      length: 2,
      child: Layout(
        secondaryColor: tool.secondaryColor,
        primaryColor: tool.primaryColor,
        textThemeStyle: tool.textThemeStyle,
        title: tool.name,
        tabBarItems: const [
          Tab(child: Text('Cronómetro')),
          Tab(child: Text('Temporizador')),
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
