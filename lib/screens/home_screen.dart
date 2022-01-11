import 'package:absurd_toolbox/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/screens/chats_screen.dart';
import 'package:absurd_toolbox/screens/maps_screen.dart';
import 'package:absurd_toolbox/screens/notes_screen.dart';
import 'package:absurd_toolbox/screens/osm_screen.dart';
import 'package:absurd_toolbox/screens/raffles_screen.dart';
import 'package:absurd_toolbox/screens/sound_recorder_screen.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/widgets/home/home_button.dart';
import 'package:absurd_toolbox/widgets/home/home_logo.dart';

class HomeScreen extends StatelessWidget {
  final List<HomeButton> homeButtons = [
    HomeButton(
      label: 'Notas',
      color: Colors.yellow,
      route: NotesScreen.routeName,
      icon: Icons.description,
    ),
    HomeButton(
      label: 'Sorteos',
      color: Colors.green.shade400,
      route: RafflesScreen.routeName,
      icon: Icons.casino,
    ),
    HomeButton(
      label: 'QR scan',
      color: Colors.teal.shade300,
      route: BarcodeScannerScreen.routeName,
      icon: Icons.qr_code_scanner,
    ),
    HomeButton(
      label: 'Grabadora',
      color: Colors.red.shade400,
      route: SoundRecorderScreen.routeName,
      icon: Icons.voicemail,
    ),
    HomeButton(
      label: 'Chats',
      color: Colors.blue.shade400,
      route: ChatsScreen.routeName,
      icon: Icons.chat,
    ),
    HomeButton(
      label: "G. Maps",
      color: Colors.lightGreen,
      route: GoogleMapsScreen.routeName,
      icon: Icons.map_outlined,
    ),
    HomeButton(
      label: "OSMaps",
      color: Colors.orange,
      route: OSMScreen.routeName,
      icon: Icons.map_sharp,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.indigo.shade700,
      content: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeLogo(),
            Flexible(
              child: GridView.count(
                padding: EdgeInsets.all(4),
                crossAxisCount: 4,
                children: homeButtons,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
