import 'package:absurd_toolbox/src/consts.dart';
import 'package:absurd_toolbox/src/models/note.dart';
import 'package:absurd_toolbox/src/models/tool.dart';
import 'package:absurd_toolbox/src/screens/toolbox_screens/notes/note_screen.dart';
import 'package:absurd_toolbox/src/services/notes_service.dart';
import 'package:absurd_toolbox/src/widgets/_general/expandable_fab/action_button.dart';
import 'package:absurd_toolbox/src/widgets/_general/expandable_fab/expandable_fab.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/widgets/notes/notes_list.dart';
import 'package:flutter/scheduler.dart';

enum ListMode {
  normal,
  selection,
}

class NotesScreenArgs {
  final bool showArchivedNotes;

  NotesScreenArgs({
    required this.showArchivedNotes,
  });
}

class NotesScreen extends StatefulWidget {
  static const String routeName = '/notes';

  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // Controla si se está en modo de visualización normal o selección
  ListMode _listMode = ListMode.normal;
  // Notas seleccionadas (en modo selección)
  List<Note> _selectedNotes = [];
  // Controla si se muestra el listado de notas normal o archivadas
  bool _showArchivedNotes = false;

  String get _title => _showArchivedNotes
      ? 'Notas archivadas'
      : tools.firstWhere((t) => t.route == NotesScreen.routeName).name;

  List<PopupMenuEntry<String>>? get _statusBarActions {
    if (_showArchivedNotes) {
      return null;
    }

    return [
      PopupMenuItem<String>(
        value: 'VIEW_ARCHIVED_NOTES',
        child: Row(
          children: [
            Container(
              child: const Icon(Icons.inventory),
              margin: const EdgeInsets.only(right: 6),
            ),
            const Text('Ver notas archivadas'),
          ],
        ),
      ),
    ];
  }

  Widget? get _fab {
    if (_listMode == ListMode.normal) {
      if (_showArchivedNotes) {
        return const ExpandableFab(
          distance: 0,
          openButtonIcon: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.black,
          ),
          children: [],
        );
      } else {
        return FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NoteScreen.routeName);
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Colors.yellow,
        );
      }
    } else {
      return ExpandableFab(
        backgroundColor: Colors.grey.shade400,
        distance: 96,
        openButtonIcon: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.black,
        ),
        children: [
          ActionButton(
            onPressed: () => _tryDeleteSelectedNotes(),
            backgroundColor: Colors.red.shade400,
            icon: const Icon(Icons.delete),
          ),
          ActionButton(
            onPressed: () => _tryToggleSelectedNotesArchive(),
            backgroundColor: Colors.lightGreen,
            icon: Icon(
              _showArchivedNotes ? Icons.unarchive : Icons.archive,
            ),
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      final args = ModalRoute.of(
        context,
      )?.settings.arguments as NotesScreenArgs?;
      if (args != null) {
        setState(() => _showArchivedNotes = args.showArchivedNotes);
      }
    });

    super.initState();
  }

  // Acción al pulsar sobre una nota
  void _onNoteTap(Note note) {
    if (_listMode == ListMode.normal) {
      Navigator.of(context).pushNamed(
        NoteScreen.routeName,
        arguments: note.id,
      );
    } else {
      _toggleNoteSelection(note);
    }
  }

  // Inicia el modo selección
  void _startSelection(Note note) {
    if (_listMode == ListMode.normal) {
      setState(() {
        _listMode = ListMode.selection;
        _selectedNotes = [note];
      });
    }
  }

  // Alterna la selección de una nota
  void _toggleNoteSelection(Note note) {
    setState(() {
      if (_selectedNotes.any((n) => n.id == note.id)) {
        _selectedNotes.removeWhere((n) => n.id == note.id);

        if (_selectedNotes.isEmpty) _listMode = ListMode.normal;
        return;
      }

      _selectedNotes.add(note);
    });
  }

  // Abre el Alert de confirmación de borrado de notas
  void _tryDeleteSelectedNotes() {
    showDialog(
      context: context,
      builder: (alertCtx) => AlertDialog(
        title: const Text('Confirmar'),
        content:
            const Text('¿Seguro que quieres eliminar las notas seleccionadas?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(alertCtx, 'Cancel');
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(alertCtx);
              _deleteSelectedNotes();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Abre el Alert de confirmación de archivado/desarchivado de notas
  void _tryToggleSelectedNotesArchive() {
    showDialog(
      context: context,
      builder: (alertCtx) => AlertDialog(
        title: const Text('Confirmar'),
        content: Text(
          _showArchivedNotes
              ? '¿Seguro que quieres desarchivar las notas seleccionadas?'
              : '¿Seguro que quieres archivar las notas seleccionadas?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(alertCtx, 'Cancel');
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(alertCtx);
              _toggleSelectedNotesArchive();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Borra las notas seleccionadas y sale del modo selección
  void _deleteSelectedNotes() {
    notesService.deleteNotes(_selectedNotes);

    setState(() {
      _listMode = ListMode.normal;
      _selectedNotes = [];
    });
  }

  // Archiva/desarchiva las notas seleccionadas y sale del modo selección
  void _toggleSelectedNotesArchive() {
    for (var note in _selectedNotes) {
      notesService.updateNote(
        Note(
          id: note.id,
          title: note.title,
          content: note.content,
          tags: note.tags,
          pinned: note.pinned,
          archived: !note.archived,
          order: note.order,
          createdAt: note.createdAt,
          updatedAt: note.updatedAt,
        ),
      );
    }

    setState(() {
      _listMode = ListMode.normal;
      _selectedNotes = [];
    });
  }

  void _onStatusBarActionSelected(String actionValue) {
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
    Tool tool = tools.firstWhere((t) => t.route == NotesScreen.routeName);

    return Layout(
      statusBarColor: tool.secondaryColor,
      themeColor: tool.primaryColor,
      themeStyle: tool.themeStyle,
      title: _title,
      statusBarActions: _statusBarActions,
      onStatusBarActionSelected: _onStatusBarActionSelected,
      content: NotesList(
        onNoteTap: _onNoteTap,
        onNoteLongPress: _startSelection,
        onSelectionToggle: _toggleNoteSelection,
        selectedNotes: _selectedNotes,
        showArchivedNotes: _showArchivedNotes,
      ),
      fab: _fab,
    );
  }
}
