import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter/providers/notes.dart';

class NotesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Notes>(
      builder: (context, notes, child) => Container(
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
    );
  }
}
