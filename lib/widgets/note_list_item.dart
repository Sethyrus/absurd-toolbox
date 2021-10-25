import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starter/models/note.dart';
import 'package:starter/screens/note_screen.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  const NoteListItem({required this.note});

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
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border(
              top: BorderSide(color: Colors.yellow.shade600, width: 3),
              bottom: BorderSide(color: Colors.yellow.shade600, width: 3),
              right: BorderSide(color: Colors.yellow.shade600, width: 3),
              left: BorderSide(color: Colors.yellow.shade800, width: 6),
            ),
          ),
          child: Text(
            note.title != '' ? note.title : '(sin título)',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
