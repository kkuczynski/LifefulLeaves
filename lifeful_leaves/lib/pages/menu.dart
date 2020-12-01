import 'package:flutter/material.dart';
import 'package:lifeful_leaves/widgets/close_menu_fab.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'menu',
          style: TextStyle(
              fontFamily: 'IndieFlower',
              color: Colors.green[700],
              fontSize: 32),
        ),
      ),
      body: RaisedButton(onPressed: () {
        Navigator.pushNamed(context, '/light');
      }),
      floatingActionButton: CloseMenuFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
