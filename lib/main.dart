import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:starter/models/note.dart';
import 'package:starter/models/route.dart' as own;
import 'package:starter/providers/notes.dart';
import 'package:starter/screens/notes_screen.dart';
import 'package:starter/widgets/material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

final List<own.Route> mainNavigation = [
  own.Route(label: 'Notas', color: Colors.yellow, route: NotesScreen.routeName),
];

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(CustomColorAdapter());
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
