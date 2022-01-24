import 'package:absurd_toolbox/src/services/notes_service.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/screens/note_screen.dart';
import 'package:absurd_toolbox/src/widgets/notes/notes_list.dart';
import 'package:flutter/scheduler.dart';

enum ListMode {
  Normal,
  Selection,
}

class NotesScreenArgs {
  final bool showArchivedNotes;

  NotesScreenArgs({
    required this.showArchivedNotes,
  });
}

class NotesScreen extends StatefulWidget {
  static const String routeName = '/notes';

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // Controla si se está en modo de visualización normal o selección
  ListMode _listMode = ListMode.Normal;
  // Notas seleccionadas (en modo selección)
  List<String> _selectedNotes = [];
  bool showArchivedNotes = false;

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final args = ModalRoute.of(
        context,
      )?.settings.arguments as NotesScreenArgs?;
      if (args != null)
        setState(() => showArchivedNotes = args.showArchivedNotes);
    });

    super.initState();
  }

  // Acción al pulsar sobre una nota
  void onNoteTap(String id) {
    if (_listMode == ListMode.Normal) {
      Navigator.of(context).pushNamed(
        NoteScreen.routeName,
        arguments: id,
      );
    } else {
      toggleNoteSelection(id);
    }
  }

  // Inicia el modo selección
  void startSelection(String id) {
    if (_listMode == ListMode.Normal) {
      setState(() {
        _listMode = ListMode.Selection;
        _selectedNotes = [id];
      });
    }
  }

  // Alterna la selección de una nota
  void toggleNoteSelection(String id) {
    setState(() {
      if (_selectedNotes.contains(id)) {
        _selectedNotes.remove(id);

        if (_selectedNotes.length == 0) _listMode = ListMode.Normal;
        return;
      }

      _selectedNotes.add(id);
    });
  }

  // Abre el Alert de confirmación de borrado de notas
  void tryDeleteSelectedNotes() {
    showDialog(
      context: context,
      builder: (alertCtx) => AlertDialog(
        title: Text('Confirmar'),
        content: Text('¿Seguro que quieres eliminar las notas seleccionadas?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(alertCtx, 'Cancel');
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(alertCtx);
              deleteSelectedNotes();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Borra las notas seleccionadas y sale del modo selección
  void deleteSelectedNotes() {
    notesService.deleteNotes(_selectedNotes);

    setState(() {
      _listMode = ListMode.Normal;
      _selectedNotes = [];
    });
  }

  void onStatusBarActionSelected(String actionValue) {
    if (actionValue == 'VIEW_ARCHIVED_NOTES') {
      Navigator.of(context).pushNamed(
        NotesScreen.routeName,
        arguments: NotesScreenArgs(
          showArchivedNotes: true,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      showAppBar: true,
      statusBarColor: Colors.yellow.shade600,
      themeColor: Colors.yellow,
      title: showArchivedNotes ? 'Notas archivadas' : 'Notas',
      statusBarActions: showArchivedNotes
          ? null
          : [
              PopupMenuItem<String>(
                value: 'VIEW_ARCHIVED_NOTES',
                child: Row(
                  children: [
                    Container(
                      child: Icon(Icons.inventory),
                      margin: EdgeInsets.only(right: 6),
                    ),
                    Text('Ver notas archivadas'),
                  ],
                ),
              ),
            ],
      onStatusBarActionSelected: onStatusBarActionSelected,
      content: NotesList(
        onNoteTap: onNoteTap,
        onNoteLongPress: startSelection,
        onSelectionToggle: toggleNoteSelection,
        selectedNotes: _selectedNotes,
        showArchivedNotes: showArchivedNotes,
      ),
      fab: (!showArchivedNotes ||
              (showArchivedNotes && _listMode == ListMode.Selection))
          ? FloatingActionButton(
              onPressed: () {
                if (_listMode == ListMode.Normal) {
                  Navigator.of(context).pushNamed(NoteScreen.routeName);
                } else {
                  tryDeleteSelectedNotes();
                }
              },
              child: Icon(
                _listMode == ListMode.Normal ? Icons.add : Icons.delete,
                color: Colors.black,
              ),
              backgroundColor:
                  _listMode == ListMode.Normal ? Colors.yellow : Colors.red,
            )
          : null,
    );
  }
}
