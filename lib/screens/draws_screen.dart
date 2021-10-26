import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:absurd_toolbox/widgets/draws/coin_draw.dart';

class DrawsScreen extends StatelessWidget {
  static const String routeName = '/draws';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            CoinDraw(),
            Divider(color: Colors.black54, thickness: 2, height: 32),
          ],
        ),
      ),
    );
  }
}
