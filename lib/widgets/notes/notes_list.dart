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
      builder: (context, stateNotes, child) => Container(
        width: double.infinity,
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: stateNotes.items.length,
          itemBuilder: (context, index) => NotesListItem(
            note: stateNotes.items[index],
            onTap: onNoteTap,
            onLongPress: onNoteLongPress,
            selectedNotes: selectedNotes,
          ),
        ),
      ),
    );
  }
}
