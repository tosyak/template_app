import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ricknotmorty/core/services/logger/app_logger.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'General Notifications',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
    icon: 'ic_launcher',
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
    iOS: iosDetails,
  );

  await notificationsPlugin.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    message.notification?.title ?? 'New Notification',
    message.notification?.body ?? '',
    platformDetails,
    payload: message.data.toString(),
  );
}

class NotificationService with AppLogger {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    await _firebaseMessaging.setAutoInitEnabled(true);
    await _setupNotificationChannels();
    await _requestPermissions();
    await _initializeNotifications();
    await getFCMToken();
    _setupListeners();
  }

  Future<String?> getFCMToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      log.severe("FCM token: $token");
      return token;
    } catch (e, stackTrace) {
      log.severe("Failed to get FCM token: $e, $stackTrace");
      return null;
    }
  }

  // --------------------------
  // Private Methods
  // --------------------------

  Future<void> _setupNotificationChannels() async {
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'General Notifications',
        description: 'Used for all app notifications',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      );

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    if (Platform.isAndroid && await _isAndroid13OrHigher()) {
      await Permission.notification.request();
    }
  }

  Future<bool> _isAndroid13OrHigher() async {
    if (!Platform.isAndroid) return false;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt >= 33;
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('ic_launcher');

    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  void _setupListeners() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen(_showForegroundNotification);

    // Background/terminated messages - using the top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      // Update token on your server or in your state management
      log.severe("FCM token refreshed: $newToken");
    });
  }

  // --------------------------
  // Notification Handlers
  // --------------------------

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    await _showNotification(
      title: message.notification?.title,
      body: message.notification?.body,
      payload: message.data.toString(),
    );
  }

  Future<void> _showNotification({
    String? title,
    String? body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'high_importance_channel',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: 'ic_launcher',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title ?? 'New Notification',
      body ?? '',
      platformDetails,
      payload: payload,
    );
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap
    if (response.payload != null) {
      // Navigate to specific screen based on payload
      log.severe("Notification tapped with payload: ${response.payload}");

      // You would typically parse the payload and navigate
      // For example:
      // final Map<String, dynamic> data = jsonDecode(response.payload!);
      // if (data.containsKey('screen')) {
      //   navigateToScreen(data['screen']);
      // }
    }
  }
}
