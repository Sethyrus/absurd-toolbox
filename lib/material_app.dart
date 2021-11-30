import 'package:absurd_toolbox/screens/barcode_scanner_screen.dart';
import 'package:absurd_toolbox/screens/sound_recorder_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/screens/raffles_screen.dart';
import 'package:absurd_toolbox/screens/note_screen.dart';
import 'package:absurd_toolbox/screens/home_screen.dart';
import 'package:absurd_toolbox/screens/notes_screen.dart';

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
        RafflesScreen.routeName: (context) => RafflesScreen(),
        BarcodeScannerScreen.routeName: (context) => BarcodeScannerScreen(),
        SoundRecorderScreen.routeName: (context) => SoundRecorderScreen(),
      },
    );
  }
}
