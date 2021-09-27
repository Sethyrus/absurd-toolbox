import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/models/note.dart';
import 'package:starter/providers/notes.dart';
import 'package:starter/widgets/notes_list.dart';

class NotesScreen extends StatelessWidget {
  static const String routeName = '/notes';

  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, notes, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notas',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          width: double.infinity,
          child: Wrap(alignment: WrapAlignment.spaceAround, children: [
            NotesList(),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print(notes.items);
            // Navigator.of(context).pushNamed(CreateNoteScreen.routeName);
            try {
              notes.addNote(
                Note(
                  title: 'title',
                  content: 'content',
                  tags: [],
                  pinned: false,
                  archived: false,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
            } catch (e) {
              print('ERROR!:');
              print(e);
            }
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }
}
