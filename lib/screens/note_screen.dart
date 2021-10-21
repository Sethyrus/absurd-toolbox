import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/models/note.dart';
import 'package:starter/providers/notes.dart';
import 'package:uuid/uuid.dart';

class NoteScreen extends StatefulWidget {
  static const String routeName = '/note';

  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  Note note = Note(
    id: '',
    title: '',
    content: '',
    tags: [],
    pinned: false,
    archived: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    final originalNote = ModalRoute.of(context)!.settings.arguments as Note?;

    if (originalNote != null) {
      setState(() {
        note = Note(
          id: originalNote.id,
          title: originalNote.title,
          content: originalNote.content,
          tags: originalNote.tags,
          pinned: originalNote.pinned,
          archived: originalNote.archived,
          createdAt: originalNote.createdAt,
          updatedAt: originalNote.updatedAt,
        );
      });
    }

    return Consumer<Notes>(
      builder: (context, notes, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Nueva nota',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Form(
          child: Container(
            color: Colors.yellow[100],
            child: ListView(
              children: [
                TextFormField(
                  onChanged: (v) {
                    setState(() {
                      note.title = v;
                    });
                  },
                  initialValue: note.title,
                  decoration: InputDecoration(
                    hintText: 'Título',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormField(
                  onChanged: (v) {
                    setState(() {
                      note.content = v;
                    });
                  },
                  initialValue: note.content,
                  decoration: InputDecoration(
                    hintText: 'Nota',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                  ),
                  maxLines: null,
                  minLines: 8,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (note.title != '' || note.content != '') {
              if (note.id == "") {
                notes.addNote(
                  Note(
                    id: Uuid().v4(),
                    title: note.title,
                    content: note.content,
                    tags: note.tags,
                    pinned: note.pinned,
                    archived: note.archived,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
              } else {
                notes.updateNote(
                  Note(
                    id: note.id,
                    title: note.title,
                    content: note.content,
                    tags: note.tags,
                    pinned: note.pinned,
                    archived: note.archived,
                    createdAt: note.createdAt,
                    updatedAt: DateTime.now(),
                  ),
                );
              }
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                (SnackBar(
                  content: Text('La nota está vacía'),
                  duration: Duration(seconds: 3),
                )),
              );
            }
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
