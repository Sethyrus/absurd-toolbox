import 'package:absurd_toolbox/src/providers/notes.dart';
import 'package:absurd_toolbox/src/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/src/screens/note_screen.dart';
import 'package:absurd_toolbox/src/widgets/notes/notes_list.dart';
import 'package:provider/provider.dart';

enum ListMode {
  Normal,
  Selection,
}

class NotesScreen extends StatefulWidget {
  static const String routeName = '/notes';

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // Controla si se está en modo de visualización normal o selección
  ListMode listMode = ListMode.Normal;
  // Notas seleccionadas (en modo selección)
  List<String> selectedNotes = [];

  // Acción al pulsar sobre una nota
  void onNoteTap(String id) {
    if (listMode == ListMode.Normal) {
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
    if (listMode == ListMode.Normal) {
      setState(() {
        listMode = ListMode.Selection;
        selectedNotes = [id];
      });
    }
  }

  // Alterna la selección de una nota
  void toggleNoteSelection(String id) {
    setState(() {
      if (selectedNotes.contains(id)) {
        selectedNotes.remove(id);

        if (selectedNotes.length == 0) listMode = ListMode.Normal;
        return;
      }

      selectedNotes.add(id);
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
    Provider.of<Notes>(context, listen: false).deleteNotes(selectedNotes);

    setState(() {
      listMode = ListMode.Normal;
      selectedNotes = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      showAppBar: true,
      statusBarColor: Colors.yellow.shade600,
      themeColor: Colors.yellow,
      title: 'Notas',
      content: NotesList(
        onNoteTap: onNoteTap,
        onNoteLongPress: startSelection,
        onSelectionToggle: toggleNoteSelection,
        selectedNotes: selectedNotes,
      ),
      fab: FloatingActionButton(
        onPressed: () {
          if (listMode == ListMode.Normal) {
            Navigator.of(context).pushNamed(NoteScreen.routeName);
          } else {
            tryDeleteSelectedNotes();
          }
        },
        child: Icon(
          listMode == ListMode.Normal ? Icons.add : Icons.delete,
          color: Colors.black,
        ),
        backgroundColor:
            listMode == ListMode.Normal ? Colors.yellow : Colors.red,
      ),
    );
  }
}