import 'package:flutter/material.dart';
import 'package:starter/screens/note_screen.dart';
import 'package:starter/widgets/notes_list.dart';

class NotesScreen extends StatelessWidget {
  static const String routeName = '/notes';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notas',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Wrap(alignment: WrapAlignment.spaceAround, children: [
          NotesList(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NoteScreen.routeName);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
