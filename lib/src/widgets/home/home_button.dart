import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String label;
  final Color color;
  final String route;
  final IconData icon;

  HomeButton({
    required this.label,
    required this.color,
    required this.route,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        borderRadius: BorderRadius.all(Radius.circular(16)),
        splashColor: Colors.grey,
        highlightColor: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: color,
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 40,
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
      ),
    );
  }
}
