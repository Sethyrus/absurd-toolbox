import 'package:absurd_toolbox/src/consts.dart';
import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class UnitConverterScreen extends StatelessWidget {
  static String routeName = "/unit-converter";

  const UnitConverterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tool tool = tools.firstWhere(
      (t) => t.route == UnitConverterScreen.routeName,
    );

    return Layout(
      secondaryColor: tool.secondaryColor,
      primaryColor: tool.primaryColor,
      themeStyle: tool.themeStyle,
      title: tool.name,
      content: const Center(
        child: Text("Conversor de unidades - En desarrollo"),
      ),
    );
  }
}
