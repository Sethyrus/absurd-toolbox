import 'package:flutter/material.dart';
import 'package:starter/screens/home_screen.dart';
import 'package:starter/screens/notas_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        NotasScreen.routeName: (context) => NotasScreen(),
      },
    );
  }
}
