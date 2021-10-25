import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/helpers.dart';
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

  bool _onSubmitForm({bool popScreen = false}) {
    log(key: 'Save note', debug: true, value: _editedNote.toJson());

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

      if (popScreen) Navigator.pop(context);
    } else {
      if (_editedNote.id != '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pueden guardar notas vacías'),
            duration: Duration(seconds: 3),
          ),
        );

        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => _onSubmitForm()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _editedNote.id == '' ? 'Nueva nota' : 'Editar nota',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            ..._editedNote.id != ''
                ? [
                    PopupMenuButton<String>(
                      onSelected: (actionValue) {
                        if (actionValue == 'DELETE') {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Confirmar'),
                              content:
                                  Text('¿Seguro que quieres eliminar la nota?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Provider.of<Notes>(
                                      context,
                                      listen: false,
                                    ).deleteNote(_editedNote);

                                    // Se lanza 2 veces, la primera para cerrar el alert y la segunda para volver al listado de notas
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'DELETE',
                          child: Text('Eliminar nota'),
                        ),
                      ],
                    )
                  ]
                : [],
          ],
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
      ),
    );
  }
}
