import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz_local;

class NotificationService {
  NotificationService() {
    _notifications = FlutterLocalNotificationsPlugin();
    _initialize();
  }

  late final FlutterLocalNotificationsPlugin _notifications;

  Future<void> _initialize() async {
    tz.initializeTimeZones();
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
    required String id,
    Map<String, dynamic>? payload,
  }) async {
    await _notifications.show(
      id: id.hashCode,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'gravity_flip_game_channel',
          'Gravity Flip Game',
          channelDescription: 'Game updates and reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: payload?.toString(),
    );
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required String id,
    required DateTime scheduledAt,
    Map<String, dynamic>? payload,
  }) async {
    final tzDate = tz_local.TZDateTime.from(scheduledAt, tz_local.local);
    await _notifications.zonedSchedule(
      id: id.hashCode,
      title: title,
      body: body,
      scheduledDate: tzDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'gravity_flip_game_channel',
          'Gravity Flip Game',
          channelDescription: 'Scheduled game reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload?.toString(),
    );
  }
}
