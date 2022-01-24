import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/services/notes_service.dart';
import 'package:absurd_toolbox/src/models/note.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/widgets/notes/notes_list_item.dart';

class NotesList extends StatelessWidget {
  final Function(String) onNoteTap;
  final Function(String) onNoteLongPress;
  final Function(String) onSelectionToggle;
  final List<String> selectedNotes;
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
      stream: notesService.notes(onlyArchivedNotes: showArchivedNotes),
      builder: (ctx, AsyncSnapshot<List<Note>> notesStream) {
        final List<Note> filteredNotes = notesStream.hasData
            ? notesStream.data
                    ?.where(
                      (n) => n.archived == showArchivedNotes,
                    )
                    .toList() ??
                []
            : [];

        return Container(
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) => DragTarget(
              onWillAccept: (editedNoteId) => true,
              onAccept: (editedNoteId) => notesService.reorderNote(
                note:
                    filteredNotes.firstWhere((note) => note.id == editedNoteId),
                newPosition: index,
              ),
              builder: (context, candidateData, rejectedData) {
                return Draggable(
                  data: filteredNotes[index].id,
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
                    selectedNotes: [],
                    floating: true,
                  ),
                  childWhenDragging: NotesListItem(
                    note: filteredNotes[index],
                    onTap: (_) {},
                    onLongPress: (_) {},
                    selectedNotes: [filteredNotes[index].id],
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
