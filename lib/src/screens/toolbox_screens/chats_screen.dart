import 'package:absurd_toolbox/src/consts.dart';
import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = '/chats';

  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Tool tool = tools.firstWhere((t) => t.route == ChatsScreen.routeName);

    return Layout(
      secondaryColor: tool.secondaryColor,
      primaryColor: tool.primaryColor,
      textThemeStyle: tool.textThemeStyle,
      title: tool.name,
      content: const Center(
        child: Text("Chats - En desarrollo"),
      ),
    );
  }
}
