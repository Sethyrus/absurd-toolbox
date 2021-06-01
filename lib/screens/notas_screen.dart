import 'package:flutter/material.dart';

class NotasScreen extends StatelessWidget {
  static const routeName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notas')),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {},
          child: Text(
            'Nota 1',
            style: TextStyle(color: Colors.black),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.yellow),
          ),
        ),
      ),
    );
  }
}
