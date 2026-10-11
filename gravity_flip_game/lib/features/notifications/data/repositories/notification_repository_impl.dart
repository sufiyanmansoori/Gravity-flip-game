import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_local_datasource.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required this._localDataSource,
    FlutterLocalNotificationsPlugin? plugin,
  }) : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final NotificationLocalDataSource _localDataSource;
  final FlutterLocalNotificationsPlugin _plugin;

  static const AndroidInitializationSettings _androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  static const DarwinInitializationSettings _iosSettings =
      DarwinInitializationSettings();

  static const InitializationSettings _initializationSettings =
      InitializationSettings(android: _androidSettings, iOS: _iosSettings);

  @override
  Future<void> initialize() async {
    tzdata.initializeTimeZones();
    await _plugin.initialize(settings: _initializationSettings);
  }

  @override
  Future<void> sendNotification({
    required String id,
    required String title,
    required String body,
    String category = 'general',
    Map<String, dynamic>? payload,
  }) async {
    final model = NotificationModel(
      id: id,
      title: title,
      body: body,
      category: category,
      payload: payload,
      createdAt: DateTime.now(),
    );

    await _plugin.show(
      id: id.hashCode,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'gravity_flip_game_channel',
          'Gravity Flip Game',
          channelDescription: 'Core game notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(payload ?? const <String, dynamic>{}),
    );

    await _localDataSource.saveQueuedNotification(model.toJson());
  }

  @override
  Future<void> scheduleNotification({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledAt,
    String category = 'general',
    Map<String, dynamic>? payload,
  }) async {
    final scheduledDate = tz.TZDateTime.from(scheduledAt, tz.local);
    final model = NotificationModel(
      id: id,
      title: title,
      body: body,
      category: category,
      payload: payload,
      createdAt: DateTime.now(),
      scheduledAt: scheduledAt,
      isScheduled: true,
    );

    await _plugin.zonedSchedule(
      id: id.hashCode,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'gravity_flip_game_channel',
          'Gravity Flip Game',
          channelDescription: 'Scheduled game notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: jsonEncode(payload ?? const <String, dynamic>{}),
    );

    await _localDataSource.saveQueuedNotification(model.toJson());
  }
}
