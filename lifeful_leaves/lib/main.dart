import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeful_leaves/pages/home.dart';
import 'package:lifeful_leaves/pages/light_check.dart';
import 'package:lifeful_leaves/pages/loading.dart';
import 'package:lifeful_leaves/pages/menu.dart';
import 'package:lifeful_leaves/pages/plant_list.dart';
import 'package:lifeful_leaves/pages/settings.dart';
import 'package:lifeful_leaves/pages/watering_list.dart';
import 'package:lifeful_leaves/pages/weather.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MaterialApp(initialRoute: '/home', routes: {
            '/': (context) => Loading(),
            '/home': (context) => Home(),
            '/menu': (context) => Menu(),
            '/light': (context) => LightCheck(),
            '/settings': (context) => Settings(),
            '/list': (context) => PlantList(),
            '/watering': (context) => WateringList(),
            '/weather': (context) => Weather(),
          })));
}
