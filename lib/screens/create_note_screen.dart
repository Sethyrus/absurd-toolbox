import 'package:flutter/material.dart';
import 'package:starter/models/note.dart';
import 'package:starter/providers/notes.dart';

class CreateNoteScreen extends StatefulWidget {
  static const String routeName = '/create-note';

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            children: [
              TextFormField(
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
          Notes().addNote(
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
          Navigator.pop(context);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
