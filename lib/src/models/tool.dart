import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';

class Tool {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final String route;
  final IconData icon;
  final Widget widget;
  final ThemeStyle themeStyle;

  const Tool({
    Key? key,
    this.themeStyle = ThemeStyle.dark,
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.route,
    required this.icon,
    required this.widget,
  });
}
