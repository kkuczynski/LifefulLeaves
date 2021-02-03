import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as notifs;
import 'package:lifeful_leaves/models/notification.dart';
import 'package:lifeful_leaves/services/database_service.dart';
import 'package:lifeful_leaves/services/watering_service.dart';
import 'package:rxdart/subjects.dart' as rxSub;

class NotificationService {
  final rxSub.BehaviorSubject<Notification> didReceiveLocalNotificationSubject =
      rxSub.BehaviorSubject<Notification>();
  final rxSub.BehaviorSubject<String> selectNotificationSubject =
      rxSub.BehaviorSubject<String>();
  final DatabaseService databaseService;
  NotificationService(this.databaseService);
  Future<void> initNotifications(
      notifs.FlutterLocalNotificationsPlugin notifsPlugin) async {
    var initializationSettingsAndroid =
        notifs.AndroidInitializationSettings('icon');
    var initializationSettingsIOS = notifs.IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(
              Notification(id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings = notifs.InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await notifsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
    print("Notifications initialised successfully");
  }

  Future<void> scheduleNotification(
      {notifs.FlutterLocalNotificationsPlugin notifsPlugin,
      int i,
      String id,
      String title,
      String body,
      DateTime scheduledTime}) async {
    var androidSpecifics = notifs.AndroidNotificationDetails(
      id,
      'Scheduled notification',
      'A scheduled notification',
      icon: 'icon',
    );
    var iOSSpecifics = notifs.IOSNotificationDetails();
    var platformChannelSpecifics =
        notifs.NotificationDetails(androidSpecifics, iOSSpecifics);
    await notifsPlugin.schedule(
        i, title, body, scheduledTime, platformChannelSpecifics);
  }

  DateTime calculateNotificationTime(int days, int hours, int mins) {
    DateTime now = DateTime.now();
    now = now.subtract(Duration(hours: now.hour, minutes: now.minute));
    now = now.add(Duration(days: days, hours: hours, minutes: mins));
    return now;
  }

  scheduleWeeklyNotifications(WateringService wateringService,
      notifs.FlutterLocalNotificationsPlugin notifsPlugin) async {
    int notifHours = databaseService.getSettingsBox().notificationsTimeHour;
    int notifMins = databaseService.getSettingsBox().notificationsTimeMinute;

    if (wateringService.getPlantsToWaterTomorrowList().length > 0) {
      scheduleNotification(
          i: 1,
          notifsPlugin: notifsPlugin,
          id: calculateNotificationTime(1, notifHours, notifMins).toString(),
          body: 'Rośliny do podlania: ' +
              wateringService.getTomorrowToWaterAmount().toString(),
          scheduledTime: calculateNotificationTime(1, notifHours, notifMins));
      print('Notification scheduled 1');
    }
    for (int i = 2; i < 8; i++) {
      if (wateringService.getAmountOfPlantsToWaterInXDaysList(i) > 0) {
        scheduleNotification(
            i: i,
            notifsPlugin: notifsPlugin,
            id: calculateNotificationTime(i, notifHours, notifMins).toString(),
            body: 'Rośliny do podlania: ' +
                wateringService.getTomorrowToWaterAmount().toString(),
            scheduledTime: calculateNotificationTime(i, notifHours, notifMins));
        print('Notification scheduled ' + i.toString());
      }
    }
  }
}
