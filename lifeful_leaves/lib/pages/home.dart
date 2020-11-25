
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text('home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/menu');
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}