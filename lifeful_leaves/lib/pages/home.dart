import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lifeful_leaves/widgets/open_menu_fab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(
          '',
          style: TextStyle(fontFamily: 'IndieFlower'),
        ),
      ),
      floatingActionButton: OpenMenuFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
