import 'package:absurd_toolbox/models/list_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/widgets/notes/note_list_item.dart';

class NotesList extends StatelessWidget {
  final ListMode listMode;
  final Function(String) onLongPress;
  final Function(String) onSelectionToggle;
  final List<String> selectedNotes;

  NotesList({
    required this.listMode,
    required this.onLongPress,
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
          itemBuilder: (context, index) => NoteListItem(
            note: stateNotes.items[index],
            onLongPress: onLongPress,
            listMode: listMode,
            onSelectionToggle: onSelectionToggle,
            selectedNotes: selectedNotes,
          ),
        ),
      ),
    );
  }
}
