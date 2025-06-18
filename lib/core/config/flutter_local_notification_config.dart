
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzData;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> init() async {
    try {
      tzData.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('Asia/Riyadh')); // Change if needed

      await _requestNotificationPermission();

      // إعدادات Android
      const androidInit = AndroidInitializationSettings('@mipmap/launcher_icon');

      // إعدادات iOS - تم إزالة onDidReceiveLocalNotification
      const iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      // إعدادات عامة
      const initSettings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await flutterLocalNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      );

      // إنشاء قناة الإشعارات للأندرويد
      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(
          const AndroidNotificationChannel(
            'medication_channel_id',
            'Medication Reminders',
            description: 'Reminder to take medication',
            importance: Importance.max,
          ),
        );
      }
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  // معالج النقر على الإشعار
  static void onDidReceiveNotificationResponse(
      NotificationResponse response) async {
    // يمكنك إضافة منطق معالجة النقر على الإشعار هنا
    print('Notification clicked: ${response.payload}');
  }

  Future<void> _requestNotificationPermission() async {
    if (Platform.isIOS) {
      // طلب إذن الإشعارات في iOS
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      // طلب إذن الإشعارات في Android
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) {
      print("Scheduled time is in the past for ID $id.");
      return;
    }

    // إعدادات الإشعار للأندرويد
    const androidDetails = AndroidNotificationDetails(
      'medication_channel_id',
      'Medication Reminders',
      channelDescription: 'Reminder to take medication',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      enableVibration: true,
      playSound: true,
    );

    // إعدادات الإشعار للـ iOS
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'default',
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleMultipleNotifications(
      List<NotificationData> notifications,
      ) async {
    for (final notification in notifications) {
      await scheduleNotification(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        scheduledDate: notification.scheduledDate,
      );
    }
  }

  // دالة لإظهار إشعار فوري
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'medication_channel_id',
      'Medication Reminders',
      channelDescription: 'Reminder to take medication',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  // دالة لإلغاء إشعار محدد
  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // دالة لإلغاء جميع الإشعارات
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

class NotificationData {
  final int id;
  final String title;
  final String body;
  final DateTime scheduledDate;

  NotificationData({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduledDate,
  });
}
