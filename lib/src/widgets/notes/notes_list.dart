import 'package:absurd_toolbox/src/blocs/notes_bloc.dart';
import 'package:absurd_toolbox/src/models/note.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/widgets/notes/notes_list_item.dart';

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
    return StreamBuilder(
      stream: notesBloc.notes,
      builder: (ctx, AsyncSnapshot<List<Note>> notes) {
        return notes.data != null
            ? Container(
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: notes.data!.length,
                  itemBuilder: (context, index) => DragTarget(
                    onWillAccept: (editedNoteId) {
                      return true;
                    },
                    onAccept: (editedNoteId) {
                      final Note changedNote = notes.data!
                          .firstWhere((note) => note.id == editedNoteId);

                      notesBloc.reorderNote(
                        note: changedNote,
                        newPosition: index,
                      );
                    },
                    builder: (context, candidateData, rejectedData) {
                      return Draggable(
                        data: notes.data![index].id,
                        child: NotesListItem(
                          note: notes.data![index],
                          onTap: onNoteTap,
                          onLongPress: onNoteLongPress,
                          selectedNotes: selectedNotes,
                        ),
                        feedback: NotesListItem(
                          note: notes.data![index],
                          onTap: onNoteTap,
                          onLongPress: onNoteLongPress,
                          // onLongPress: (_) {},
                          selectedNotes: selectedNotes,
                        ),
                        childWhenDragging: NotesListItem(
                          note: notes.data![index],
                          onTap: (_) {},
                          onLongPress: (_) {},
                          selectedNotes: [notes.data![index].id],
                        ),
                      );
                    },
                  ),
                ),
              )
            : SizedBox.shrink();
      },
    );
  }
}
