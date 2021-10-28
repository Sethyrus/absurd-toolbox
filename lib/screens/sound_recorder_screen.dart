import 'package:absurd_toolbox/widgets/_general/layout.dart';
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
    return Layout(
      statusBarColor: Colors.red,
      themeColor: Colors.red.shade400,
      title: 'Grabadora de sonidos',
      showAppBar: true,
      content: Container(),
      fab: FloatingActionButton(
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
