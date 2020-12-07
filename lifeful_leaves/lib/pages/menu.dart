import 'package:flutter/material.dart';
import 'package:lifeful_leaves/widgets/close_menu_fab.dart';
import 'package:lifeful_leaves/widgets/menu_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Container( // TODO: fix nav bar color when going back to menu
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: MenuButton(
                        label: 'Naświetlenie',
                        icon: Icons.wb_sunny_outlined,
                        path: '/light'),
                  ),
                  Expanded(
                    flex: 5,
                    child: MenuButton(
                        label: 'Ustawienia',
                        icon: Icons.settings_outlined,
                        path: '/settings'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: MenuButton(
                        label: 'Rośliny',
                        icon: Icons.format_list_bulleted,
                        path: '/list'),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: MenuButton(
                        label: 'Do podlania',
                        icon: Icons.opacity,
                        path: '/watering'),
                  ),
                  Expanded(
                    flex: 5,
                    child: MenuButton(
                        label: 'Stacja pogodowa',
                        icon: FaIcon(FontAwesomeIcons.thermometerHalf).icon,
                        path: '/weather'),
                  ),
                ],
              )
            ]),
      ),
      floatingActionButton: CloseMenuFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
