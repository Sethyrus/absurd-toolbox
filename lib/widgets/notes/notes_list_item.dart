import 'package:flutter/material.dart';
import 'package:absurd_toolbox/models/note.dart';

class NotesListItem extends StatelessWidget {
  final Note note;
  final Function(String) onTap;
  final Function(String) onLongPress;
  final List<String> selectedNotes;

  const NotesListItem({
    required this.note,
    required this.onTap,
    required this.onLongPress,
    required this.selectedNotes,
  });

  BoxDecoration noteStyles() {
    if (!selectedNotes.contains(note.id)) {
      return BoxDecoration(
        color: Colors.yellow,
        border: Border(
          top: BorderSide(color: Colors.yellow.shade700, width: 2),
          bottom: BorderSide(color: Colors.yellow.shade700, width: 2),
          right: BorderSide(color: Colors.yellow.shade700, width: 2),
          left: BorderSide(color: Colors.yellow.shade700, width: 6),
        ),
      );
    } else {
      return BoxDecoration(
        color: Colors.grey.shade400,
        border: Border(
          top: BorderSide(color: Colors.grey.shade500, width: 2),
          bottom: BorderSide(color: Colors.grey.shade500, width: 2),
          right: BorderSide(color: Colors.grey.shade500, width: 2),
          left: BorderSide(color: Colors.grey.shade500, width: 10),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => onTap(note.id),
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
