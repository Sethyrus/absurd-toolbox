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

  var titleController = new TextEditingController();
  var contentController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
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

        titleController.value = TextEditingValue(
          text: originalNote.title,
          selection: TextSelection.fromPosition(
            TextPosition(offset: originalNote.title.length),
          ),
        );

        contentController.value = TextEditingValue(
          text: originalNote.content,
          selection: TextSelection.fromPosition(
            TextPosition(offset: originalNote.content.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Notes notes = Provider.of<Notes>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          note.id == '' ? 'Nueva nota' : 'Editar nota',
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
                controller: titleController,
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
                controller: contentController,
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
                  title: titleController.value.text,
                  content: contentController.value.text,
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
                  title: titleController.value.text,
                  content: contentController.value.text,
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
              SnackBar(
                content: Text('No se pueden crear notas vacías'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        },
        child: Icon(Icons.save),
      ),
      // ),
    );
  }
}
