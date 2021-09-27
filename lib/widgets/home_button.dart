import 'package:flutter/material.dart';
import 'package:starter/models/route.dart' as own;

class HomeButton extends StatelessWidget {
  final own.Route route;

  HomeButton({
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route.route);
      },
      child: Ink(
        color: route.color,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Text(
            route.label,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
