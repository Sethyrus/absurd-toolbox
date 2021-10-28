import 'package:absurd_toolbox/widgets/_general/layout.dart';
import 'package:flutter/material.dart';
import 'package:absurd_toolbox/main.dart';
import 'package:absurd_toolbox/widgets/home/home_button.dart';
import 'package:absurd_toolbox/widgets/home/home_logo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Layout(
        statusBarColor: Colors.indigo.shade700,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeLogo(),
            Flexible(
              child: GridView.count(
                padding: EdgeInsets.all(4),
                crossAxisCount: 4,
                children: List.generate(
                  mainNavigation.length,
                  (index) => Padding(
                    padding: EdgeInsets.all(4),
                    child: HomeButton(route: mainNavigation[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
