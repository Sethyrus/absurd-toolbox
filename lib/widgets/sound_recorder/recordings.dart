import 'package:flutter/material.dart';

class Recordings extends StatefulWidget {
  @override
  _RecordingsState createState() => _RecordingsState();
}

class _RecordingsState extends State<Recordings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(
        'En desarrollo',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
