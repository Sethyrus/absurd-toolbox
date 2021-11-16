import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color statusBarColor;

  EmptyAppBar({required this.statusBarColor});

  @override
  Widget build(BuildContext context) => Container(
        color: statusBarColor,
      );

  @override
  Size get preferredSize => Size(0.0, 0.0);
}
