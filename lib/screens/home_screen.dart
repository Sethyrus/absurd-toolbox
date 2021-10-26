import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:absurd_toolbox/main.dart';
import 'package:absurd_toolbox/widgets/home/home_button.dart';
import 'package:absurd_toolbox/widgets/home/home_logo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.indigo[700],
        ),
        child: SafeArea(
          child: Column(
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
      ),
    );
  }
}
