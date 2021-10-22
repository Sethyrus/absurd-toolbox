import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/providers/notes.dart';
import 'package:starter/widgets/note_list_item.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, stateNotes, child) => Container(
        width: double.infinity,
        child: Wrap(
          children: stateNotes.items
              .map(
                (n) => NoteListItem(
                  note: n,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
