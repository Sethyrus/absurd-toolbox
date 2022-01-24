import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final Color? backgroundColor;

  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
