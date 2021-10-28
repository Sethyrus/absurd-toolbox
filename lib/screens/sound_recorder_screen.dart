import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SoundRecorderScreen extends StatefulWidget {
  static const String routeName = '/sound-recorder';

  @override
  State<SoundRecorderScreen> createState() => _SoundRecorderScreenState();
}

class _SoundRecorderScreenState extends State<SoundRecorderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Grabadora de sonidos',
          style: TextStyle(color: Colors.black),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.red,
        ),
        backgroundColor: Colors.red.shade400,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.mic,
          color: Colors.black,
        ),
        backgroundColor: Colors.red.shade400,
      ),
    );
  }
}
