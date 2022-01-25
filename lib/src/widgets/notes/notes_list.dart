import 'package:absurd_toolbox/src/services/notes_service.dart';
import 'package:absurd_toolbox/src/models/note.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/widgets/notes/notes_list_item.dart';

class NotesList extends StatelessWidget {
  final Function(Note) onNoteTap;
  final Function(Note) onNoteLongPress;
  final Function(Note) onSelectionToggle;
  final List<Note> selectedNotes;
  final bool showArchivedNotes;

  NotesList({
    required this.onNoteTap,
    required this.onNoteLongPress,
    required this.onSelectionToggle,
    required this.selectedNotes,
    this.showArchivedNotes = false,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: notesService.notesStream,
      builder: (ctx, AsyncSnapshot<List<Note>> notesStream) {
        final List<Note> filteredNotes = [];

        if (notesStream.hasData && notesStream.data != null)
          notesStream.data!.forEach((note) {
            if (note.archived == showArchivedNotes) filteredNotes.add(note);
          });

        return Container(
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) => DragTarget(
              onWillAccept: (_) => true,
              onAccept: (Note draggedNote) => notesService.reorderNote(
                note: draggedNote,
                newPosition: index,
              ),
              builder: (context, candidateData, rejectedData) {
                return Draggable(
                  data: filteredNotes[index],
                  child: NotesListItem(
                    note: filteredNotes[index],
                    onTap: onNoteTap,
                    onLongPress: onNoteLongPress,
                    selectedNotes: selectedNotes,
                  ),
                  feedback: NotesListItem(
                    note: filteredNotes[index],
                    onTap: onNoteTap,
                    onLongPress: (_) {},
                    selectedNotes: selectedNotes,
                    floating: true,
                  ),
                  childWhenDragging: NotesListItem(
                    note: filteredNotes[index],
                    onTap: (_) {},
                    onLongPress: (_) {},
                    selectedNotes: [filteredNotes[index]],
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
