import 'package:app_template/common/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart' as url_launcher_string;

class AppUtils {
  AppUtils._();

  static void launchUrlString(
    String urlString, {
    url_launcher.LaunchMode mode = url_launcher.LaunchMode.platformDefault,
  }) async {
    try {
      final canLaunch = await url_launcher_string.canLaunchUrlString(urlString);
      if (canLaunch) {
        await url_launcher_string.launchUrlString(
          urlString,
          mode: mode,
        );
      }
    } catch (error, stackTrace) {
      Logger.logError(
        'Error launchUrlString',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static void copyToClipboard(
    BuildContext context, {
    required String text,
  }) async {
    try {
      await Clipboard.setData(
        ClipboardData(text: text),
      );
      HapticFeedback.lightImpact();
    } catch (error, stackTrace) {
      Logger.logError(
        'Error copyToClipboard',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static void callPhone(String phoneNumber) async {
    try {
      await launchUrl(
        Uri(
          scheme: 'tel',
          path: phoneNumber,
        ),
      );
    } catch (error, stackTrace) {
      Logger.logError(
        'Error callPhone',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
