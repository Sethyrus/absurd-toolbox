import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String label;
  final Color color;
  final String route;
  final IconData icon;

  const HomeButton({
    Key? key,
    required this.label,
    required this.color,
    required this.route,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        splashColor: Colors.grey,
        highlightColor: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(
                  icon,
                  size: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                child: Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
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
