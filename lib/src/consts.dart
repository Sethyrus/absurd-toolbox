import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/src/screens/chats_screen.dart';
import 'package:absurd_toolbox/src/screens/clock_screen.dart';
import 'package:absurd_toolbox/src/screens/flashlight_screen.dart';
import 'package:absurd_toolbox/src/screens/notes/notes_screen.dart';
import 'package:absurd_toolbox/src/screens/raffles_screen.dart';
import 'package:absurd_toolbox/src/screens/sound_recorder_screen.dart';
import 'package:flutter/material.dart';

final List<Tool> tools = [
  Tool(
    name: "Notas",
    icon: Icons.description,
    primaryColor: Colors.yellow,
    secondaryColor: Colors.yellow.shade600,
    route: NotesScreen.routeName,
    widget: NotesScreen(),
  ),
  Tool(
    name: "Aleatoriedad",
    icon: Icons.casino,
    primaryColor: Colors.green.shade400,
    secondaryColor: Colors.green,
    route: RafflesScreen.routeName,
    widget: RafflesScreen(),
  ),
  Tool(
    name: "Medición de tiempo",
    icon: Icons.access_time,
    primaryColor: Colors.orange.shade400,
    secondaryColor: Colors.orange,
    route: ClockScreen.routeName,
    widget: const ClockScreen(),
  ),
  Tool(
    name: "Escáner QR",
    icon: Icons.qr_code_scanner,
    primaryColor: Colors.teal.shade300,
    secondaryColor: Colors.teal.shade400,
    route: BarcodeScannerScreen.routeName,
    widget: BarcodeScannerScreen(),
  ),
  Tool(
    name: "Grabadora de voz",
    icon: Icons.voicemail,
    primaryColor: Colors.red.shade400,
    secondaryColor: Colors.red,
    route: SoundRecorderScreen.routeName,
    widget: SoundRecorderScreen(),
  ),
  Tool(
    name: "Chats",
    icon: Icons.chat,
    primaryColor: Colors.blue.shade400,
    secondaryColor: Colors.blue.shade600,
    route: ChatsScreen.routeName,
    widget: const ChatsScreen(),
  ),
  Tool(
    name: "Linterna",
    icon: Icons.flashlight_on,
    primaryColor: Colors.purple.shade300,
    secondaryColor: Colors.purple.shade400,
    route: FlashlightScreen.routeName,
    widget: FlashlightScreen(),
  ),
];
