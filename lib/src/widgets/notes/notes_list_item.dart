import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/models/note.dart';

class NotesListItem extends StatelessWidget {
  final Note note;
  final Function(Note) onTap;
  final Function(Note) onLongPress;
  final List<Note> selectedNotes;
  final bool floating;

  const NotesListItem({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onLongPress,
    required this.selectedNotes,
    this.floating = false,
  });

  bool get _isNoteSelected => selectedNotes.any((n) => n.id == note.id);

  BoxDecoration _noteStyles() {
    if (!_isNoteSelected) {
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
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: floating ? _noteStyles() : null,
            width: MediaQuery.of(context).size.width - 16,
            child: InkWell(
              onTap: () => onTap(note),
              onLongPress: () {
                onLongPress(note);
              },
              child: Ink(
                decoration: floating ? null : _noteStyles(),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                child: Text(
                  note.title != '' ? note.title : '(sin título)',
                  style: const TextStyle(
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
