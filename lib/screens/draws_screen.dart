import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter/widgets/draws/coin_draw.dart';

class DrawsScreen extends StatefulWidget {
  static const String routeName = '/draws';

  @override
  _DrawsScreenState createState() => _DrawsScreenState();
}

class _DrawsScreenState extends State<DrawsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sorteos',
          style: TextStyle(color: Colors.black),
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.green,
        ),
        backgroundColor: Colors.green[400],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: CoinDraw(),
    );
  }
}
