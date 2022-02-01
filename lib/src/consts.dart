import 'package:absurd_toolbox/src/models/raffle.dart';
import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/clock_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/flashlight_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/notes/notes_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/raffles_screen.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/unit_converter_screen.dart';
import 'package:absurd_toolbox/src/widgets/raffles/dice.dart';
import 'package:absurd_toolbox/src/widgets/raffles/heads_or_tails.dart';
import 'package:absurd_toolbox/src/widgets/raffles/lottery.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

final List<Tool> tools = [
  Tool(
    name: "Notas",
    icon: Icons.description,
    primaryColor: Colors.yellow,
    secondaryColor: Colors.yellow.shade600,
    route: NotesScreen.routeName,
    widget: const NotesScreen(),
  ),
  Tool(
    name: "Aleatoriedad",
    icon: Icons.casino,
    primaryColor: Colors.green.shade400,
    secondaryColor: Colors.green,
    route: RafflesScreen.routeName,
    widget: const RafflesScreen(),
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
    widget: const BarcodeScannerScreen(),
  ),
  // Tool(
  //   name: "Grabadora de sonido",
  //   icon: Icons.voicemail,
  //   primaryColor: Colors.red.shade400,
  //   secondaryColor: Colors.red,
  //   route: SoundRecorderScreen.routeName,
  //   widget: const SoundRecorderScreen(),
  // ),
  // Tool(
  //   name: "Chats",
  //   icon: Icons.chat,
  //   primaryColor: Colors.blue.shade400,
  //   secondaryColor: Colors.blue.shade600,
  //   route: ChatsScreen.routeName,
  //   widget: const ChatsScreen(),
  // ),
  Tool(
    name: "Linterna",
    icon: Icons.flashlight_on,
    primaryColor: Colors.purple.shade300,
    secondaryColor: Colors.purple.shade400,
    route: FlashlightScreen.routeName,
    widget: const FlashlightScreen(),
  ),
  Tool(
    name: "Conversor de unidades",
    icon: MdiIcons.scaleBalance,
    primaryColor: Colors.brown.shade400,
    secondaryColor: Colors.brown,
    route: UnitConverterScreen.routeName,
    widget: const UnitConverterScreen(),
  ),
];

final List<Raffle> raffles = [
  Raffle(
    mode: RaffleMode.headsOrTails,
    name: "Cara o cruz",
    widget: const HeadsOrTails(),
  ),
  Raffle(
    mode: RaffleMode.lottery,
    name: "Sorteo",
    widget: const Lottery(),
  ),
  Raffle(
    mode: RaffleMode.diceRoll,
    name: "Dados",
    widget: const DiceRoll(),
  ),
];
