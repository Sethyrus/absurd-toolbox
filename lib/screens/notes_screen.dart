import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/screens/note_screen.dart';
import 'package:absurd_toolbox/widgets/notes/notes_list.dart';

class NotesScreen extends StatelessWidget {
  static const String routeName = '/notes';

  @override
  Widget build(BuildContext context) {
    return Layout(
      showAppBar: true,
      statusBarColor: Colors.yellow.shade600,
      themeColor: Colors.yellow,
      title: 'Notas',
      content: NotesList(),
      fab: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(NoteScreen.routeName),
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
