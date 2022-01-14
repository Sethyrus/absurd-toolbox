import 'package:absurd_toolbox/src/blocs/notes_bloc.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/note.dart';
import 'package:uuid/uuid.dart';

class NoteScreen extends StatefulWidget {
  static const String routeName = '/note';

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  var _initialized = false;
  Note _originalNote = Note(
    id: '',
    title: '',
    content: '',
    tags: [],
    pinned: false,
    archived: false,
    order: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  Note _editedNote = Note(
    id: '',
    title: '',
    content: '',
    tags: [],
    pinned: false,
    archived: false,
    order: 0,
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

      if (noteId != null) {
        _originalNote = notesBloc.findById(noteId);

        _editedNote = notesBloc.findById(noteId);
      }
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _contentFocusNode.dispose();
    super.dispose();
  }

  bool _onSubmitForm({bool popScreen = false}) {
    _form.currentState!.save();

    if (_editedNote.title != '' || _editedNote.content != '') {
      if (_editedNote.id == "") {
        log(key: 'Save new note', value: _editedNote.toJson());

        notesBloc.addNote(
          Note(
            id: Uuid().v4(),
            title: _editedNote.title,
            content: _editedNote.content,
            tags: _editedNote.tags,
            pinned: _editedNote.pinned,
            archived: _editedNote.archived,
            order: notesBloc.notesSync.length > 0
                ? notesBloc.notesSync[notesBloc.notesSync.length - 1].order + 1
                : 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      } else {
        // Se comprueba si se han hecho cambios para actualizar solo en ese caso
        if (!(_originalNote.title == _editedNote.title &&
            _originalNote.content == _editedNote.content)) {
          log(key: 'Edit note', value: _editedNote.toJson());

          notesBloc.updateNote(
            Note(
              id: _editedNote.id,
              title: _editedNote.title,
              content: _editedNote.content,
              tags: _editedNote.tags,
              pinned: _editedNote.pinned,
              archived: _editedNote.archived,
              order: _editedNote.order,
              createdAt: _editedNote.createdAt,
              updatedAt: DateTime.now(),
            ),
          );
        }
      }

      if (popScreen) Navigator.pop(context);
    } else {
      if (_editedNote.id != '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("No se pueden guardar notas vacías"),
            duration: Duration(seconds: 3),
          ),
        );

        return false;
      }
    }

    return true;
  }

  void onStatusBarActionSelected(String actionValue) {
    if (actionValue == 'DELETE') {
      showDialog(
        context: context,
        builder: (alertCtx) => AlertDialog(
          title: Text('Confirmar'),
          content: Text('¿Seguro que quieres eliminar la nota?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(alertCtx, 'Cancel');
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                notesBloc.deleteNote(_editedNote);

                // Se lanza 2 veces, la primera cierra el alert y la segunda vuelve al listado de notas
                Navigator.pop(alertCtx);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future(() => _onSubmitForm()),
      child: Layout(
        statusBarColor: Colors.yellow.shade600,
        themeColor: Colors.yellow,
        showAppBar: true,
        title: _editedNote.id == '' ? 'Nueva nota' : 'Editar nota',
        statusBarActions: _editedNote.id != ''
            ? [
                PopupMenuItem<String>(
                  value: 'DELETE',
                  child: Row(
                    children: [
                      Container(
                        child: Icon(Icons.delete),
                        margin: EdgeInsets.only(right: 6),
                      ),
                      Text('Eliminar nota'),
                    ],
                  ),
                ),
              ]
            : null,
        onStatusBarActionSelected: onStatusBarActionSelected,
        content: Form(
          key: _form,
          child: Container(
            color: Colors.yellow.shade100,
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
                        order: _editedNote.order,
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
                      vertical: 0,
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
                          order: _editedNote.order,
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
                        vertical: 0,
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
