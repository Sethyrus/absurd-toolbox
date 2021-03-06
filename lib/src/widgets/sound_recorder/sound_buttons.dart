import 'package:flutter/material.dart';

class SoundButtons extends StatefulWidget {
  const SoundButtons({Key? key}) : super(key: key);

  @override
  _SoundButtonsState createState() => _SoundButtonsState();
}

class _SoundButtonsState extends State<SoundButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: const Text(
        'Sound buttons - En desarrollo',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
