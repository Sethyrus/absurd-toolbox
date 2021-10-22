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
  // String id = '';
  // String title = '';
  // String content = '';
  bool initialized = false;
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
        print('Hay nota');
        setState(() {
          // id = originalNote.id;
          // title = originalNote.title;
          // content = originalNote.content;
          print('Seteando nota');
          print(originalNote.toJson());

          initialized = true;
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
      } else {
        print('Qué va no hay nota');
      }
    });
    // new Future.delayed(Duration.zero, () {
    //   final originalNote = ModalRoute.of(context)!.settings.arguments as Note?;

    //   if (originalNote != null) {
    //     print('Hay nota');
    //     // setState(() {
    //     // id = originalNote.id;
    //     // title = originalNote.title;
    //     // content = originalNote.content;
    //     print('Seteando nota');
    //     print(originalNote.toJson());

    //     initialized = true;
    //     note = Note(
    //       id: originalNote.id,
    //       title: originalNote.title,
    //       content: originalNote.content,
    //       tags: originalNote.tags,
    //       pinned: originalNote.pinned,
    //       archived: originalNote.archived,
    //       createdAt: originalNote.createdAt,
    //       updatedAt: originalNote.updatedAt,
    //     );
    //     // });
    //   } else {
    //     print('Qué va no hay nota');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final originalNote = ModalRoute.of(context)!.settings.arguments as Note?;

    // if (!initialized && originalNote != null) {
    //   print('Hay nota');
    //   setState(() {
    //     // id = originalNote.id;
    //     // title = originalNote.title;
    //     // content = originalNote.content;

    //     initialized = true;
    //     note = Note(
    //       id: originalNote.id,
    //       title: originalNote.title,
    //       content: originalNote.content,
    //       tags: originalNote.tags,
    //       pinned: originalNote.pinned,
    //       archived: originalNote.archived,
    //       createdAt: originalNote.createdAt,
    //       updatedAt: originalNote.updatedAt,
    //     );
    //   });
    // }

    return Consumer<Notes>(
      builder: (context, notes, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            // id == '' ? 'Nueva nota' : 'Editar nota',
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
                  onChanged: (v) {
                    setState(() {
                      note.title = v;
                      // title = v;
                    });
                  },
                  controller: titleController,
                  // initialValue: title,
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
                      // content = v;
                      note.content = v;
                    });
                  },
                  controller: contentController,
                  // initialValue: note.content,
                  // initialValue: content,
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
            // if (title != '' || content != '') {
            if (note.title != '' || note.content != '') {
              if (note.id == "") {
                // if (id == "") {
                print(000000000);
                print(note.title);
                print(note.content);
                notes.addNote(
                  note: Note(
                    id: Uuid().v4(),
                    title: note.title,
                    content: note.content,
                    tags: [],
                    pinned: false,
                    archived: false,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
                // notes.addNote(title: note.title, content: note.content);
                // notes.addNote(title: title, content: content);
              } else {
                print(1111111);
                print(titleController.value.text);
                // print(title);
                notes.updateNote(
                  // id: id,
                  // title: title,
                  // content: content,

                  note: note,
                );
              }
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('La nota está vacía'),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
