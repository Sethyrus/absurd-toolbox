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
    return Text(_parsedTime);
  }
}
