import 'package:flutter/material.dart';
import 'package:lifeful_leaves/widgets/close_menu_fab.dart';

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
      floatingActionButton: CloseMenuFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
