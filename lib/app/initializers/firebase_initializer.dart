import 'package:app_template/common/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> initializeFirebase() async {
  try {
    final firebaseApp = await Firebase.initializeApp();

    Logger.firebase.log(
      'isAutomaticDataCollectionEnabled: ${firebaseApp.isAutomaticDataCollectionEnabled}',
    );

    if (kDebugMode) {
      try {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        Logger.firebase.log('fcmToken: $fcmToken');
      } catch (error) {
        Logger.firebase.log('fcmToken: $error');
      }
    }

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: false);
      return true;
    };

    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    }

    return;
  } catch (error, stackTrace) {
    Logger.logError(
      'Error initializeFirebase',
      error: error,
      stackTrace: stackTrace,
    );
    return;
  }
}
