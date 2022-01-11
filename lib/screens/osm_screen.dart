import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class OSMScreen extends StatelessWidget {
  static const String routeName = '/osmaps';

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.orange.shade600,
      title: "Open Street Maps",
      themeColor: Colors.orange,
      showAppBar: true,
      content: Center(),
    );
  }
}
