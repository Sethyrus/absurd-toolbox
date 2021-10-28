import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/draws/raffle.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/widgets/draws/coin_draw.dart';

class DrawsScreen extends StatelessWidget {
  static const String routeName = '/draws';

  @override
  Widget build(BuildContext context) {
    return Layout(
      statusBarColor: Colors.green,
      themeColor: Colors.green.shade400,
      showAppBar: true,
      title: 'Sorteos',
      content: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            CoinDraw(),
            Divider(color: Colors.black54, thickness: 2, height: 32),
            Raffle(),
          ],
        ),
      ),
    );
  }
}
