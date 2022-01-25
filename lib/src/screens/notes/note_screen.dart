import 'package:absurd_toolbox/src/services/notes_service.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/helpers.dart';
import 'package:absurd_toolbox/src/models/note.dart';
import 'package:flutter/scheduler.dart';
import 'package:uuid/uuid.dart';

class NoteScreen extends StatefulWidget {
  static const String routeName = '/note';

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  bool _initialized = false;
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

  String get _title => _editedNote.id == '' ? 'Nueva nota' : 'Editar nota';

  List<PopupMenuEntry<String>>? get _statusBarActions {
    if (_editedNote.id != '') {
      return [
        PopupMenuItem<String>(
          value: 'TOGGLE_ARCHIVE',
          child: Row(
            children: [
              Container(
                child: Icon(
                  _editedNote.archived ? Icons.unarchive : Icons.archive,
                ),
                margin: EdgeInsets.only(right: 6),
              ),
              Text(
                _editedNote.archived ? 'Desarchivar nota' : 'Archivar nota',
              ),
            ],
          ),
        ),
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
      ];
    }

    return null;
  }

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final noteId = ModalRoute.of(context)?.settings.arguments as String?;

      log("Loading note with id: $noteId");

      if (noteId != null) {
        final foundNote = notesService.findById(noteId);

        if (foundNote == null) {
          showToast(context, "No se ha podido encontrar la nota");
          Navigator.of(context).pop();
        } else {
          setState(() {
            _originalNote = foundNote.clone();
            _editedNote = foundNote.clone();
            _initialized = true;
          });
        }
      } else {
        setState(() {
          _initialized = true;
        });
      }
    });

    super.initState();
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
        log('Save new note', _editedNote.toJson());

        notesService.addNote(
          Note(
            id: Uuid().v4(),
            title: _editedNote.title,
            content: _editedNote.content,
            tags: _editedNote.tags,
            pinned: _editedNote.pinned,
            archived: _editedNote.archived,
            order: notesService.notesSync.length > 0
                ? notesService
                        .notesSync[notesService.notesSync.length - 1].order +
                    1
                : 0,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
      } else {
        // Se comprueba si se han hecho cambios para actualizar solo en tal caso
        if (!_editedNote.isSameAs(_originalNote)) {
          log('Edit note', _editedNote.toJson());

          notesService.updateNote(
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
        showToast(context, "No se pueden guardar notas vacías");
        return false;
      }
    }

    return true;
  }

  void _onStatusBarActionSelected(String actionValue) {
    switch (actionValue) {
      case "DELETE":
        {
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
                    notesService.deleteNote(_editedNote);

                    // Se lanza 2 veces, la primera cierra el alert y la segunda vuelve al listado de notas
                    Navigator.pop(alertCtx);
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
          break;
        }
      case "TOGGLE_ARCHIVE":
        {
          setState(() {
            _editedNote = Note(
              id: _editedNote.id,
              title: _editedNote.title,
              content: _editedNote.content,
              tags: _editedNote.tags,
              pinned: _editedNote.pinned,
              archived: !_editedNote.archived,
              order: _editedNote.order,
              createdAt: _editedNote.createdAt,
              updatedAt: _editedNote.updatedAt,
            );
          });
          break;
        }
      default:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return _initialized
        ? WillPopScope(
            onWillPop: () => Future(() => _onSubmitForm()),
            child: Layout(
              statusBarColor: Colors.yellow.shade600,
              themeColor: Colors.yellow,
              title: _title,
              statusBarActions: _statusBarActions,
              onStatusBarActionSelected: _onStatusBarActionSelected,
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
                          FocusScope.of(context)
                              .requestFocus(_contentFocusNode);
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
          )
        : SizedBox.shrink();
  }
}
