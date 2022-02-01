import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = '/chats';

  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.blue.shade600,
      themeColor: Colors.blue.shade400,
      title: 'Chats',
      content: const Center(
        child: Text("Chats - En desarrollo"),
      ),
    );
  }
}
