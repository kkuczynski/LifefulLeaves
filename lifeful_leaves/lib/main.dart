import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:lifeful_leaves/pages/add_plant.dart';
import 'package:lifeful_leaves/pages/camera.dart';
import 'package:lifeful_leaves/pages/home.dart';
import 'package:lifeful_leaves/pages/light_check.dart';
import 'package:lifeful_leaves/pages/loading.dart';
import 'package:lifeful_leaves/pages/menu.dart';
import 'package:lifeful_leaves/pages/plant_list.dart';
import 'package:lifeful_leaves/pages/settings.dart';
import 'package:lifeful_leaves/pages/watering_list.dart';
import 'package:lifeful_leaves/pages/weather.dart';

Future<void> changeSystemColors(Color color, bool ifWhite) async {
  await FlutterStatusbarcolor.setNavigationBarColor(color);
  FlutterStatusbarcolor.setNavigationBarWhiteForeground(ifWhite);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MaterialApp(
            initialRoute: '/home',
            routes: {
              '/': (context) => Loading(),
              '/home': (context) => Home(),
              '/menu': (context) => Menu(),
              '/light': (context) => LightCheck(),
              '/settings': (context) => Settings(),
              '/list': (context) => PlantList(),
              '/watering': (context) => WateringList(),
              '/weather': (context) => Weather(),
              '/add_plant': (context) => AddPlant(camera: firstCamera),
              '/camera': (context) => Camera(camera: firstCamera),
            },
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.green[700],
              accentColor: Colors.black,
              buttonColor: Colors.green[700],
              cursorColor: Colors.green[700],
              focusColor: Colors.green[700],
            ),
          )));
}
