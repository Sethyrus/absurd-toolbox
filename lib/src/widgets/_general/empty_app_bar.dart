import 'package:flutter/material.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color statusBarColor;

  const EmptyAppBar({Key? key, required this.statusBarColor}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: statusBarColor,
      );

  @override
  Size get preferredSize => const Size(0.0, 0.0);
}
