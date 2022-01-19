import 'package:flutter/material.dart';

void log(String key, [Object? value, bool? debug = true]) {
  print((debug == true ? '[DEBUG] ' : '') + key + (value != null ? ': ' : ''));

  if (value != null) print(value);
}

bool isEmailValid(String email) => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);

void showToast(
  BuildContext context,
  String text, {
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(text),
      duration: duration,
    ),
  );
}
