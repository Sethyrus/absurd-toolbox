import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime _currTime = new DateTime.now();
  Timer? _clockTimer;

  String get _parsedTime => DateFormat('HH:mm:ss').format(_currTime);
  String get _parsedDate => DateFormat.yMMMMEEEEd().format(_currTime);

  @override
  void initState() {
    super.initState();

    _clockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => _currTime = new DateTime.now());
    });
  }

  @override
  void dispose() {
    _clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 32,
        left: 8,
        right: 8,
        bottom: 8,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _parsedTime,
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(_parsedDate),
        ],
      ),
    );
  }
}
