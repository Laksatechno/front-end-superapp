import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:yofa/datasources/auth/auth_remote_datasource.dart';

/// Top-level handler — must be a plain function (not a method/closure).
/// Called when a FCM message arrives while the app is in the background/terminated.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Firebase is already initialized before this is called by the plugin.
  print('FCM [background] id=${message.messageId} title=${message.notification?.title}');
}

class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  final _fcm = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  /// Android notification channel for high-importance messages.
  static const _androidChannel = AndroidNotificationChannel(
    'yofa_high_importance_channel',
    'Notifikasi Yofa',
    description: 'Notifikasi penting dari aplikasi Yofa',
    importance: Importance.high,
  );

  /// Initialize everything. Call this once after Firebase.initializeApp().
  Future<void> init() async {
    // 1. Register background handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // 2. Request permission (Android 13+ / iOS)
    await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 3. Set up local notifications (for foreground messages on Android)
    await _initLocalNotifications();

    // 4. Foreground message handler
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 5. Notification tap when app is in background (not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // 6. Check if app was launched from a terminated-state notification
    final initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _handleMessageOpenedApp(initialMessage);
    }

    // 7. Persist FCM token & listen for refreshes
    await _setupToken();
  }

  // ---------------------------------------------------------------------------
  // Local notifications setup
  // ---------------------------------------------------------------------------

  Future<void> _initLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle tap on local notification (foreground)
        print('Local notification tapped: ${details.payload}');
      },
    );

    // Create the Android channel so high-importance heads-up notifications work.
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_androidChannel);
    }
  }

  // ---------------------------------------------------------------------------
  // Token management
  // ---------------------------------------------------------------------------

  Future<void> _setupToken() async {
    final token = await _fcm.getToken();
    if (token != null) {
      await _sendTokenToServer(token);
    }

    // Refresh listener — called whenever FCM rotates the token.
    _fcm.onTokenRefresh.listen(_sendTokenToServer);
  }

  Future<void> _sendTokenToServer(String token) async {
    print('FCM token: $token');
    await AuthRemoteDatasource().updateFcmToken(token);
  }

  // ---------------------------------------------------------------------------
  // Message handlers
  // ---------------------------------------------------------------------------

  void _handleForegroundMessage(RemoteMessage message) {
    print('FCM [foreground] title=${message.notification?.title}');
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@mipmap/ic_launcher',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
      payload: message.data.toString(),
    );
  }

  void _handleMessageOpenedApp(RemoteMessage message) {
    // Navigate or handle deep-link based on message.data if needed.
    print('FCM [opened] title=${message.notification?.title} data=${message.data}');
  }
}
