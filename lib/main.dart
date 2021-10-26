import 'package:absurd_toolbox/screens/barcode_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absurd_toolbox/models/route.dart' as own;
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/screens/draws_screen.dart';
import 'package:absurd_toolbox/screens/notes_screen.dart';
import 'package:absurd_toolbox/material_app.dart';

final List<own.Route> mainNavigation = [
  own.Route(
    label: 'Notas',
    color: Colors.yellow,
    route: NotesScreen.routeName,
    icon: Icons.description,
  ),
  own.Route(
    label: 'Sorteos',
    color: Colors.green.shade400,
    route: DrawsScreen.routeName,
    icon: Icons.casino,
  ),
  own.Route(
    label: 'QR scan',
    color: Colors.teal.shade300,
    route: BarcodeScannerScreen.routeName,
    icon: Icons.qr_code_scanner,
  ),
];

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Foco dummy
  final FocusNode _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Notes(),
      child: GestureDetector(
        // Elimina el foco de cualquier input al pulsar sobre un espacio libre
        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
        child: MyMaterialApp(),
      ),
    );
  }
}
