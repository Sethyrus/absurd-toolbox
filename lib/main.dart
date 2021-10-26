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
];

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Notes(),
      child: MyMaterialApp(),
    );
  }
}
