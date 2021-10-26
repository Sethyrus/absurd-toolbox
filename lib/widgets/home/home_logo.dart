import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.indigo[400],
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.construction,
            size: 64,
            color: Colors.yellow[600],
          ),
          Text(
            'Absurd Toolbox',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.yellow[600],
            ),
          ),
        ],
      ),
    );
  }
}
