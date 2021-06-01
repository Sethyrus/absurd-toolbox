import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/providers/notes.dart';
import 'package:starter/screens/create_note_screen.dart';

class NotesScreen extends StatelessWidget {
  static const routeName = '';

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notas',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.spaceAround,
          children: notes.items
              .map(
                (n) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      n.title,
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(n.color),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateNoteScreen.routeName);
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
