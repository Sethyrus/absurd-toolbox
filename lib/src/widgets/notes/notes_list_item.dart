import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/models/note.dart';

class NotesListItem extends StatelessWidget {
  final Note note;
  final Function(Note) onTap;
  final Function(Note) onLongPress;
  final List<Note> selectedNotes;
  final bool floating;

  const NotesListItem({
    required this.note,
    required this.onTap,
    required this.onLongPress,
    required this.selectedNotes,
    this.floating = false,
  });

  bool get isNoteSelected => selectedNotes.contains(note);

  BoxDecoration noteStyles({bool hasBorder = true}) {
    if (!isNoteSelected) {
      return BoxDecoration(
        color: Colors.yellow,
        border: hasBorder
            ? Border(
                top: BorderSide(color: Colors.yellow.shade700, width: 2),
                bottom: BorderSide(color: Colors.yellow.shade700, width: 2),
                right: BorderSide(color: Colors.yellow.shade700, width: 2),
                left: BorderSide(color: Colors.yellow.shade700, width: 6),
              )
            : null,
      );
    } else {
      return BoxDecoration(
        color: Colors.grey.shade400,
        border: hasBorder
            ? Border(
                top: BorderSide(color: Colors.grey.shade500, width: 2),
                bottom: BorderSide(color: Colors.grey.shade500, width: 2),
                right: BorderSide(color: Colors.grey.shade500, width: 2),
                left: BorderSide(color: Colors.grey.shade500, width: 10),
              )
            : null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: floating ? noteStyles() : null,
            width: MediaQuery.of(context).size.width - 16,
            child: InkWell(
              onTap: () => onTap(note),
              onLongPress: () {
                onLongPress(note);
              },
              child: Ink(
                decoration: floating ? null : noteStyles(),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
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
          ),
        ],
      ),
    );
  }
}
