import 'package:absurd_toolbox/models/note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/widgets/notes/notes_list_item.dart';

class NotesList extends StatelessWidget {
  final Function(String) onNoteTap;
  final Function(String) onNoteLongPress;
  final Function(String) onSelectionToggle;
  final List<String> selectedNotes;

  NotesList({
    required this.onNoteTap,
    required this.onNoteLongPress,
    required this.onSelectionToggle,
    required this.selectedNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, stateNotes, child) {
        return Container(
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: stateNotes.items.length,
            itemBuilder: (context, index) => DragTarget(
              onWillAccept: (editedNoteId) {
                return true;
              },
              onAccept: (editedNoteId) {
                final Note changedNote = stateNotes.items
                    .firstWhere((note) => note.id == editedNoteId);

                stateNotes.reorderNote(
                  note: changedNote,
                  newPosition: index,
                );
              },
              builder: (context, candidateData, rejectedData) {
                return Draggable(
                  data: stateNotes.items[index].id,
                  child: NotesListItem(
                    note: stateNotes.items[index],
                    onTap: onNoteTap,
                    onLongPress: onNoteLongPress,
                    selectedNotes: selectedNotes,
                  ),
                  feedback: NotesListItem(
                    note: stateNotes.items[index],
                    onTap: onNoteTap,
                    onLongPress: onNoteLongPress,
                    // onLongPress: (_) {},
                    selectedNotes: selectedNotes,
                  ),
                  childWhenDragging: NotesListItem(
                    note: stateNotes.items[index],
                    onTap: (_) {},
                    onLongPress: (_) {},
                    selectedNotes: [stateNotes.items[index].id],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
