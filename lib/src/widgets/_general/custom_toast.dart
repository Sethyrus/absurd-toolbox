import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;

  CustomToast({
    required this.text,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor ?? Colors.black87,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
