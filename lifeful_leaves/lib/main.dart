import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hive/hive.dart';
import 'package:lifeful_leaves/models/plant.dart';
import 'package:lifeful_leaves/models/settings.dart';
import 'package:lifeful_leaves/models/weekly_conditions.dart';
import 'package:lifeful_leaves/pages/add_plant.dart';
import 'package:lifeful_leaves/pages/camera.dart';
import 'package:lifeful_leaves/pages/home.dart';
import 'package:lifeful_leaves/pages/light_check.dart';
import 'package:lifeful_leaves/pages/menu.dart';
import 'package:lifeful_leaves/pages/plant_list.dart';
import 'package:lifeful_leaves/pages/settings_page.dart';
import 'package:lifeful_leaves/pages/watering_list.dart';
import 'package:lifeful_leaves/pages/weather.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lifeful_leaves/services/daily_weather_service.dart';
import 'package:lifeful_leaves/services/database_service.dart';
import 'package:lifeful_leaves/services/watering_service.dart';
import 'package:workmanager/workmanager.dart';

Future<void> changeSystemColors(Color color, bool ifWhite) async {
  await FlutterStatusbarcolor.setNavigationBarColor(color);
  FlutterStatusbarcolor.setNavigationBarWhiteForeground(ifWhite);
}

// void callbackDispatcher() {
//   Workmanager.executeTask((task, inputData) async {
//     switch (task) {
//       case "backgroundTask":
//         await Hive.initFlutter();
//         var plantBox = await Hive.openBox<Plant>('box_for_plant');
//         var settingsBox = await Hive.openBox<Settings>('box_for_settings');
//         var weeklyConditionsBox =
//             await Hive.openBox<WeeklyConditions>('box_for_weekly_conditions');
//         final DatabaseService dbService =
//             DatabaseService(plantBox, settingsBox, weeklyConditionsBox);
//         await DailyWeatherService(dbService).dailyWeatherUpdate();
//     }
//     return Future.value(true);
//   });
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlantAdapter());
  Hive.registerAdapter(SettingsAdapter());
  Hive.registerAdapter(WeeklyConditionsAdapter());
  var plantBox = await Hive.openBox<Plant>('box_for_plant');
  var settingsBox = await Hive.openBox<Settings>('box_for_settings');
  var weeklyConditionsBox =
      await Hive.openBox<WeeklyConditions>('box_for_weekly_conditions');
  final DatabaseService dbService =
      DatabaseService(plantBox, settingsBox, weeklyConditionsBox);
  final WateringService wateringService = WateringService(dbService);
  //settingsBox.clear();
  dbService.initDefaultSettings();
  dbService.fillWeeklyConditionsWithDefaultValues();
  final DailyWeatherService dailyWeatherService =
      DailyWeatherService(dbService);
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  // Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  // Workmanager.registerPeriodicTask(
  //   "1",
  //   "backgroundTask",
  //   frequency: Duration(days: 1),
  //   constraints: Constraints(
  //     networkType: NetworkType.connected,
  //   ),
  //   existingWorkPolicy: ExistingWorkPolicy.replace,
  // );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MaterialApp(
            initialRoute: '/home',
            routes: {
              '/home': (context) => Home(
                    wateringService: wateringService,
                    dbService: dbService,
                    dailyWeatherService: dailyWeatherService,
                  ),
              '/menu': (context) => Menu(),
              '/light': (context) => LightCheck(),
              '/settings': (context) => SettingsPage(dbService: dbService),
              '/list': (context) =>
                  PlantList(dbService: dbService, camera: firstCamera),
              '/watering': (context) => WateringList(
                    wateringService: wateringService,
                    dbService: dbService,
                  ),
              '/weather': (context) => Weather(
                    dbService: dbService,
                  ),
              '/add_plant': (context) => AddPlant(
                    camera: firstCamera,
                    dbService: dbService,
                  ),
              '/camera': (context) => Camera(camera: firstCamera),
            },
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.green[700],
                accentColor: Colors.black,
                buttonColor: Colors.green[700],
                cursorColor: Colors.green[700],
                focusColor: Colors.green[700],
                indicatorColor: Colors.green[700],
                dividerColor: Colors.green[700],
                textSelectionHandleColor: Colors.green[700],
                fontFamily: 'IndieFlower'),
          )));
}
