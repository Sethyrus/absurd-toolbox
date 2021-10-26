import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/providers/notes.dart';
import 'package:starter/screens/draws_screen.dart';
import 'package:starter/screens/note_screen.dart';
import 'package:starter/screens/home_screen.dart';
import 'package:starter/screens/notes_screen.dart';

class MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Notes>(context, listen: false).reloadNotesFromStorage();

    return MaterialApp(
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        NotesScreen.routeName: (context) => NotesScreen(),
        NoteScreen.routeName: (context) => NoteScreen(),
        DrawsScreen.routeName: (context) => DrawsScreen(),
      },
    );
  }
}
