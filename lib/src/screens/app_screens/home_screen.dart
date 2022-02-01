import 'package:absurd_toolbox/src/consts.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/widgets/home/tool_button.dart';
import 'package:absurd_toolbox/src/widgets/home/home_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Theme.of(context).primaryColorDark,
      themeColor: Theme.of(context).primaryColor,
      themeStyle: ThemeStyle.light,
      showAppBar: false,
      title: "Absurd Toolbox",
      content: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeLogo(),
            Flexible(
              child: GridView.count(
                padding: const EdgeInsets.all(4),
                crossAxisCount: 4,
                children: List.generate(
                  tools.length,
                  (i) => ToolButton(tool: tools[i]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
