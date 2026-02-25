import 'dart:convert';
import 'dart:io';

import 'package:jenosize/data/models/version_status.dart';
import 'package:jenosize/domain/api_client/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class StoreVersionRemoteDataSource {
  final ApiClient _apiClient;

  /// Only affects iOS App Store lookup: The two-letter country code for the store you want to search.
  /// Provide a value here if your app is only available outside the US.
  /// For example: US. The default is US.
  /// See http://en.wikipedia.org/wiki/ ISO_3166-1_alpha-2 for a list of ISO Country Codes.
  final String? iOSAppStoreCountry;

  /// Only affects Android Play Store lookup: The two-letter country code for the store you want to search.
  /// Provide a value here if your app is only available outside the US.
  /// For example: US. The default is US.
  /// See http://en.wikipedia.org/wiki/ ISO_3166-1_alpha-2 for a list of ISO Country Codes.
  /// see https://www.ibm.com/docs/en/radfws/9.6.1?topic=overview-locales-code-pages-supported
  final String? androidPlayStoreCountry;

  const StoreVersionRemoteDataSource(
    this._apiClient, {
    this.iOSAppStoreCountry,
    this.androidPlayStoreCountry,
  });

  /// This checks the version status and returns the information. This is useful
  /// if you want to display a custom alert, or use the information in a different
  /// way.
  Future<VersionStatus?> getVersionStatus() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isIOS) {
      return _getiOSStoreVersion(packageInfo);
    } else if (Platform.isAndroid) {
      return _getAndroidStoreVersion(packageInfo);
    } else {
      debugPrint(
        'The target platform "${kIsWeb ? 'web' : Platform.operatingSystem}" is not yet supported by this package.',
      );
      return null;
    }
  }

  /// This function attempts to clean local version strings so they match the MAJOR.MINOR.PATCH
  /// versioning pattern, so they can be properly compared with the store version.
  String _getCleanVersion(String version) {
    return RegExp(r'\d+(\.\d+)?(\.\d+)?').stringMatch(version) ?? '0.0.0';
  }

  /// iOS info is fetched by using the iTunes lookup API, which returns a
  /// JSON document.
  Future<VersionStatus?> _getiOSStoreVersion(PackageInfo packageInfo) async {
    final id = packageInfo.packageName;

    Map<String, dynamic> parameters = {};

    if (id.contains('.')) {
      parameters['bundleId'] = id;
    } else {
      parameters['id'] = id;
    }

    parameters['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString();

    if (iOSAppStoreCountry != null) {
      parameters.addAll({'country': iOSAppStoreCountry!});
    }

    var uri = Uri.https('itunes.apple.com', '/lookup', parameters);

    Response response;

    try {
      response = await _apiClient.getUri(uri);
    } catch (e) {
      debugPrint('Failed to query iOS App Store\n$e');
      return null;
    }

    if (response.statusCode != 200) {
      debugPrint('Invalid response code: ${response.statusCode}');
      return null;
    }

    final jsonObj = json.decode(response.data);
    final List results = jsonObj['results'];
    if (results.isEmpty) {
      debugPrint('Can\'t find an app in the App Store with the id: $id');
      return null;
    }

    return VersionStatus(
      localVersion: _getCleanVersion(packageInfo.version),
      storeVersion: _getCleanVersion(jsonObj['results'][0]['version']),
      appStoreLink: jsonObj['results'][0]['trackViewUrl'],
    );
  }

  /// Android info is fetched by parsing the html of the app store page.
  Future<VersionStatus?> _getAndroidStoreVersion(
    PackageInfo packageInfo,
  ) async {
    final id = packageInfo.packageName;

    final uri = Uri.https(
      'play.google.com',
      '/store/apps/details',
      {
        'id': id.toString(),
        'hl': androidPlayStoreCountry ?? 'en_US',
        'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      },
    );

    Response response;

    try {
      response = await _apiClient.getUri(uri);
    } catch (e) {
      debugPrint('Failed to query Google Play Store\n$e');
      return null;
    }

    if (response.statusCode != 200) {
      debugPrint('Invalid response code: ${response.statusCode}');
      return null;
    }

    /// Supports 1.2.3 (most of the apps) and 1.2.prod.3 (e.g. Google Cloud)
    final regexp = RegExp(
      r'\[\[\[\"(\d+\.\d+(\.[a-z]+)?(\.([^"]|\\")*)?)\"\]\]',
    );
    final storeVersion = regexp.firstMatch(response.data)?.group(1);

    return VersionStatus(
      localVersion: _getCleanVersion(packageInfo.version),
      storeVersion: _getCleanVersion(storeVersion ?? ''),
      appStoreLink: uri.toString(),
    );
  }
}
