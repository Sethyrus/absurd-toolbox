import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/route.dart' as own;
import 'package:absurd_toolbox/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/screens/notes_screen.dart';
import 'package:absurd_toolbox/screens/raffles_screen.dart';
import 'package:absurd_toolbox/screens/sound_recorder_screen.dart';

final List<own.Route> appRoutes = [
  own.Route(
    label: 'Notas',
    color: Colors.yellow,
    route: NotesScreen.routeName,
    icon: Icons.description,
  ),
  own.Route(
    label: 'Sorteos',
    color: Colors.green.shade400,
    route: RafflesScreen.routeName,
    icon: Icons.casino,
  ),
  own.Route(
    label: 'QR scan',
    color: Colors.teal.shade300,
    route: BarcodeScannerScreen.routeName,
    icon: Icons.qr_code_scanner,
  ),
  own.Route(
    label: 'Grabadora',
    color: Colors.red.shade400,
    route: SoundRecorderScreen.routeName,
    icon: Icons.voicemail,
  ),
];
