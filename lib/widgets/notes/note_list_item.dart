import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/note.dart';
import 'package:absurd_toolbox/screens/note_screen.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            NoteScreen.routeName,
            arguments: note.id,
          );
        },
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border(
              top: BorderSide(color: Colors.yellow.shade700, width: 2),
              bottom: BorderSide(color: Colors.yellow.shade700, width: 2),
              right: BorderSide(color: Colors.yellow.shade700, width: 2),
              left: BorderSide(color: Colors.yellow.shade700, width: 6),
            ),
          ),
          child: Text(
            note.title != '' ? note.title : '(sin título)',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
