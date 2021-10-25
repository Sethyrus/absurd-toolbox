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
  var _initialized = false;
  Note _editedNote = Note(
    id: '',
    title: '',
    content: '',
    tags: [],
    pinned: false,
    archived: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  final _form = GlobalKey<FormState>();
  final _contentFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      _initialized = true;

      final noteId = ModalRoute.of(context)!.settings.arguments as String?;

      if (noteId != null)
        _editedNote = Provider.of<Notes>(
          context,
          listen: false,
        ).findById(noteId);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _onSubmitForm() {
    _form.currentState!.save();

    if (_editedNote.title != '' || _editedNote.content != '') {
      Notes notes = Provider.of<Notes>(context, listen: false);

      if (_editedNote.id == "") {
        notes.addNote(
          Note(
            id: Uuid().v4(),
            title: _editedNote.title,
            content: _editedNote.content,
            tags: _editedNote.tags,
            pinned: _editedNote.pinned,
            archived: _editedNote.archived,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      } else {
        notes.updateNote(
          Note(
            id: _editedNote.id,
            title: _editedNote.title,
            content: _editedNote.content,
            tags: _editedNote.tags,
            pinned: _editedNote.pinned,
            archived: _editedNote.archived,
            createdAt: _editedNote.createdAt,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editedNote.id == '' ? 'Nueva nota' : 'Editar nota',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _form,
        child: Container(
          color: Colors.yellow[100],
          height: double.infinity,
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  if (value != null)
                    _editedNote = Note(
                      id: _editedNote.id,
                      title: value,
                      content: _editedNote.content,
                      tags: _editedNote.tags,
                      pinned: _editedNote.pinned,
                      archived: _editedNote.archived,
                      createdAt: _editedNote.createdAt,
                      updatedAt: _editedNote.updatedAt,
                    );
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contentFocusNode);
                },
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
                initialValue: _editedNote.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: TextFormField(
                  expands: true,
                  focusNode: _contentFocusNode,
                  onSaved: (value) {
                    if (value != null)
                      _editedNote = Note(
                        id: _editedNote.id,
                        title: _editedNote.title,
                        content: value,
                        tags: _editedNote.tags,
                        pinned: _editedNote.pinned,
                        archived: _editedNote.archived,
                        createdAt: _editedNote.createdAt,
                        updatedAt: _editedNote.updatedAt,
                      );
                  },
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Nota',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 8,
                    ),
                  ),
                  initialValue: _editedNote.content,
                  maxLines: null,
                  minLines: null,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onSubmitForm,
        child: Icon(Icons.save),
      ),
    );
  }
}
