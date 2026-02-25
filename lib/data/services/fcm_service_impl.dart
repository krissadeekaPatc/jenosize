import 'dart:convert';
import 'dart:io';

import 'package:app_template/common/logger.dart';
import 'package:app_template/data/enums/fcm_target_type.dart';
import 'package:app_template/data/models/fcm_payload.dart';
import 'package:app_template/domain/services/fcm_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final fcmNotifier = ValueNotifier<FcmPayload?>(null);

class FcmServiceImpl implements FcmService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin;
  final FirebaseMessaging _firebaseMessaging;
  final Stream<RemoteMessage> _onMessage;
  final Stream<RemoteMessage> _onMessageOpenedApp;

  FcmPayload? initialPayload;

  FcmServiceImpl(
    this._localNotificationsPlugin,
    this._firebaseMessaging,
    this._onMessage,
    this._onMessageOpenedApp,
  );

  Future<void> initialize() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      sound: true,
      badge: true,
      alert: true,
    );

    await _initLocalNotifications();

    _onMessage
        .listen(_onMessageListener)
        .onError(
          (e, s) => Logger.logError(
            'Error onMessage',
            error: e,
            stackTrace: s,
          ),
        );

    _onMessageOpenedApp
        .listen(_onMessageOpenedAppListener)
        .onError(
          (e, s) => Logger.logError(
            'Error onMessageOpenedApp',
            error: e,
            stackTrace: s,
          ),
        );
  }

  Future<void> _initLocalNotifications() async {
    final initSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _localNotificationsPlugin.initialize(
      initSettings,

      /// When tap notification Android Foreground
      onDidReceiveNotificationResponse: _onTapNotification,
    );
  }

  /// When tap notification Android foreground
  void _onTapNotification(NotificationResponse response) {
    final responsePayload = response.payload;
    if (responsePayload == null) return;
    try {
      final json = jsonDecode(responsePayload);
      final payload = FcmPayload.fromJsonOrNull(json);
      if (payload == null) return;
      _onOpenMessage(payload);
    } catch (error, stackTrace) {
      Logger.logError(
        'Error onTapNotification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  void _onMessageListener(RemoteMessage remoteMessage) async {
    /// if this is available when Platform.isIOS, you'll receive the notification twice
    if (Platform.isAndroid) {
      final notification = remoteMessage.notification;
      if (notification != null) {
        final notificationDetails = const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            priority: Priority.max,
            importance: Importance.max,
          ),
        );

        await _localNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          notificationDetails,
          payload: jsonEncode(remoteMessage.data),
        );
      }
    }

    _handleOnForegroundNotificationData(remoteMessage);
  }

  /// When tap notification Android background
  /// When tap notification iOS foreground/background
  void _onMessageOpenedAppListener(RemoteMessage remoteMessage) {
    final payload = FcmPayload.fromJsonOrNull(remoteMessage.data);
    if (payload == null) return;
    _onOpenMessage(payload);
    if (fcmNotifier.value != payload) {
      _onNewMessage(payload);
    }
  }

  /// When receive notification on Foreground
  void _handleOnForegroundNotificationData(RemoteMessage remoteMessage) {
    final payload = FcmPayload.fromJsonOrNull(remoteMessage.data);
    if (payload == null) return;
    _onNewMessage(payload);
  }

  @override
  void openInitialMessage() {
    final payload = initialPayload;
    if (payload == null) return;
    _onOpenMessage(payload);
    initialPayload = null;
  }

  void _onNewMessage(FcmPayload payload) {
    fcmNotifier.value = payload;
  }

  void _onOpenMessage(FcmPayload payload) {
    switch (payload.targetType) {
      case null:
        break;

      case FcmTargetType.unknown:
        break;
    }
  }
}
