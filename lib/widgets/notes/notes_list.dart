import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:absurd_toolbox/providers/notes.dart';
import 'package:absurd_toolbox/widgets/notes/note_list_item.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, stateNotes, child) => Container(
        width: double.infinity,
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: stateNotes.items.length,
          itemBuilder: (context, index) =>
              NoteListItem(stateNotes.items[index]),
        ),
      ),
    );
  }
}
