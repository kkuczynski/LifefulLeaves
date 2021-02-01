import 'package:flutter/material.dart';
import 'package:lifeful_leaves/pages/menu.dart';

class OpenMenuFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Menu()),
        );
      },
      child: Container(
        width: 51,
        height: 51,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.green[700], width: 2.0)),
        child: Icon(
          Icons.apps,
          color: Colors.green[700],
          size: 30.0,
        ),
      ),
      backgroundColor: Colors.green[300],
    );
  }
}
