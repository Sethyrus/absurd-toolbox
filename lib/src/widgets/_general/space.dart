import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double size;

  Space({required this.size});

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}
