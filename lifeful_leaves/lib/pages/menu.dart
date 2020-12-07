import 'package:flutter/material.dart';
import 'package:lifeful_leaves/widgets/close_menu_fab.dart';
import 'package:lifeful_leaves/widgets/menu_button.dart';

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
      body: Container(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MenuButton(
                      label: "Sprawdź naświetlenie",
                      icon: Icons.wb_sunny_outlined,
                      path: '/light')
                ],
              ),
            ]),
      ),
      floatingActionButton: CloseMenuFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
