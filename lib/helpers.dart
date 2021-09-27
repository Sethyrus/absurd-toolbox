import 'package:flutter/material.dart';
import 'package:starter/models/note.dart';

Color convertCustomColorToColor(CustomColor customColor) {
  switch (customColor) {
    case CustomColor.yellow:
      {
        return Colors.yellow;
      }
    case CustomColor.red:
      {
        return Colors.red;
      }
  }
}
