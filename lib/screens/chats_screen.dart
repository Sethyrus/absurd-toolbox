import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  static const String routeName = '/chats';

  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      showAppBar: true,
      statusBarColor: Colors.blue.shade600,
      themeColor: Colors.blue.shade400,
      title: 'Chats',
      content: Center(
        child: Text("Chats"),
      ),
    );
  }
}
