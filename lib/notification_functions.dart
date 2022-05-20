import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

initialiseNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}

showNotification(int id, String name, String number, String date) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'channel id',
    'channel name',
    channelDescription: 'channel description',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  tz.initializeTimeZones();

  if (minutesToExpiry(date) > 840) {
    tz.TZDateTime scheduledDate =
        tz.TZDateTime.now(tz.local).add(minutesToNotify(date));

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Recharge expiring tomorrow',
        'Your recharge for $name ($number) is expiring tomorrow.',
        scheduledDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  } else {
    tz.TZDateTime scheduledDate =
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10));

    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        'Recharge expiring soon',
        'Your recharge for $name ($number) is expiring very soon.',
        scheduledDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}

Duration minutesToNotify(String date) {
  int minutes = minutesToExpiry(date) - 840;

  print(date);
  print(DateTime.parse(date));
  print(DateTime.parse(date).difference(DateTime.now()).inMinutes);
  print(minutes);

  Duration duration = Duration(minutes: minutes);
  return duration;
}

int minutesToExpiry(String date) {
  return DateTime.parse(date).difference(DateTime.now()).inMinutes;
}

deleteNotificationSchedule(int id) async {
  await flutterLocalNotificationsPlugin.cancel(id);
}
