import 'dart:async';
import 'package:flutter/material.dart';

class Chronometer extends StatefulWidget {
  const Chronometer({Key? key}) : super(key: key);

  @override
  State<Chronometer> createState() => _ChronometerState();
}

class _ChronometerState extends State<Chronometer> {
  bool _isInit = false;
  bool _isCounting = false;
  DateTime _startTime = DateTime.now();
  Timer? _chronometerTimer;

  String get _parsedElapsedTime {
    if (!_isInit) return "00:00:00";

    String elapsedTimeStr = "";

    final Duration elapsedTimeDuration = DateTime.now().difference(_startTime);

    String toDigits(int n, int d) => n.toString().padLeft(d, "0");

    // Minutos
    elapsedTimeStr += toDigits(elapsedTimeDuration.inMinutes.remainder(60), 2);
    elapsedTimeStr += ":";
    // Segundos
    elapsedTimeStr += toDigits(elapsedTimeDuration.inSeconds.remainder(60), 2);
    elapsedTimeStr += ":";
    // Milisegundos
    elapsedTimeStr +=
        toDigits((elapsedTimeDuration.inMilliseconds ~/ 10).remainder(100), 2);

    return elapsedTimeStr;
  }

  @override
  void dispose() {
    _chronometerTimer?.cancel();
    super.dispose();
  }

  _toggleChronometer() {
    if (_isCounting) {
      _chronometerTimer?.cancel();
      setState(() => _isCounting = false);
      return;
    }

    setState(() {
      _startTime = DateTime.now();
      _isCounting = true;
      _isInit = true;
    });

    _chronometerTimer = Timer.periodic(
      const Duration(milliseconds: 10),
      (timer) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 32,
        bottom: 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _parsedElapsedTime,
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: _toggleChronometer,
            child: Text(_isCounting ? "Detener" : "Iniciar"),
          ),
        ],
      ),
    );
  }
}
