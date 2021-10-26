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
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Navigator.of(context).pushNamed(route.route);
      },
      splashColor: Colors.grey,
      highlightColor: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: route.color,
          border: Border.all(
            color: Colors.black12,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(
              route.icon,
              size: 40,
            ),
            Text(
              route.label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
