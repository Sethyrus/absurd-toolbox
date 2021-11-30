import 'package:absurd_toolbox/models/draw_mode.dart';
import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:absurd_toolbox/widgets/draws/raffle.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/widgets/draws/coin_draw.dart';

class DrawsScreen extends StatefulWidget {
  static const String routeName = '/draws';

  @override
  State<DrawsScreen> createState() => _DrawsScreenState();
}

class _DrawsScreenState extends State<DrawsScreen> {
  DrawMode drawMode = DrawMode.coinDraw;

  Widget drawWidget() {
    if (drawMode == DrawMode.coinDraw) {
      return CoinDraw();
    } else {
      return Raffle();
    }
  }

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
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Text("Cara o cruz"),
                  value: DrawMode.coinDraw,
                ),
                DropdownMenuItem(
                  child: Text("Sorteo"),
                  value: DrawMode.raffle,
                ),
              ],
              onChanged: (DrawMode? value) {
                if (value != null) {
                  setState(() {
                    drawMode = value;
                  });
                }
              },
              hint: Text(
                drawMode == DrawMode.coinDraw ? "Cara o cruz" : "Sorteo",
              ),
            ),
            Divider(color: Colors.black54, thickness: 2, height: 32),
            drawWidget(),
          ],
        ),
      ),
    );
  }
}
