import 'package:absurd_toolbox/models/list_mode.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/note.dart';
import 'package:absurd_toolbox/screens/note_screen.dart';

class NoteListItem extends StatelessWidget {
  final Note note;
  final ListMode listMode;
  final Function(String) onLongPress;
  final Function(String) onSelectionToggle;
  final List<String> selectedNotes;

  const NoteListItem({
    required this.note,
    required this.listMode,
    required this.onLongPress,
    required this.onSelectionToggle,
    required this.selectedNotes,
  });

  BoxDecoration noteStyles() {
    return listMode == ListMode.normal || !selectedNotes.contains(note.id)
        ? BoxDecoration(
            color: Colors.yellow,
            border: Border(
              top: BorderSide(color: Colors.yellow.shade700, width: 2),
              bottom: BorderSide(color: Colors.yellow.shade700, width: 2),
              right: BorderSide(color: Colors.yellow.shade700, width: 2),
              left: BorderSide(color: Colors.yellow.shade700, width: 6),
            ),
          )
        : BoxDecoration(
            color: Colors.grey,
            border: Border(
              top: BorderSide(color: Colors.grey.shade700, width: 2),
              bottom: BorderSide(color: Colors.grey.shade700, width: 2),
              right: BorderSide(color: Colors.grey.shade700, width: 2),
              left: BorderSide(color: Colors.grey.shade700, width: 10),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          if (listMode == ListMode.normal) {
            Navigator.of(context).pushNamed(
              NoteScreen.routeName,
              arguments: note.id,
            );
          } else {
            onSelectionToggle(note.id);
          }
        },
        onLongPress: () {
          onLongPress(note.id);
        },
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: noteStyles(),
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
