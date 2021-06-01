import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/providers/notes.dart';
import 'package:starter/screens/create_note_screen.dart';
import 'package:starter/screens/home_screen.dart';
import 'package:starter/screens/notes_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Notes(),
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          NotesScreen.routeName: (context) => NotesScreen(),
          CreateNoteScreen.routeName: (context) => CreateNoteScreen(),
        },
      ),
    );
  }
}
