import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AlertService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  AlertService() {
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    notificationsPlugin.initialize(initializationSettings);
  }

  void sendAlert(String message) async {
    const androidDetails = AndroidNotificationDetails(
      'alert_channel', // Channel ID
      'Route Alerts', // Channel name
      channelDescription: 'Alerts for route deviation', // Channel description
      importance: Importance.high, // Set importance level
      priority: Priority.high, // Set priority level
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await notificationsPlugin.show(0, 'Route Alert', message, notificationDetails);
  }
}
