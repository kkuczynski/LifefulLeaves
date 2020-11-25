import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(child: Text('MENU PAGE')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Container(
            width: 51,
            height: 51,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green[700], width: 2.0)),
            child: Center(
              child: Text(
                'x',
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 18.0,

                ),
              ),
            )),
        backgroundColor: Colors.green[300],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}