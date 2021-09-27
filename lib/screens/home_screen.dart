import 'package:flutter/material.dart';
import 'package:starter/main.dart';
import 'package:starter/widgets/grid.dart';
import 'package:starter/widgets/home_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio')),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Grid(
            cols: 3,
            outterMarginsOffset: 8,
            children: List.generate(
              mainNavigation.length,
              (index) => HomeButton(route: mainNavigation[index]),
            ),
          ),
        ],
      ),
    );
  }
}
