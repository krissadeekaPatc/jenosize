import 'package:flutter/services.dart';

enum Flavor {
  dev,
  uat,
  prod;

  static Flavor get current {
    switch (appFlavor) {
      case 'dev':
        return Flavor.dev;
      case 'uat':
        return Flavor.uat;
      case 'prod':
        return Flavor.prod;
      default:
        throw ArgumentError(
          'Invalid flavor: $appFlavor.\n'
          'Please specify a valid flavor using --flavor dev, uat, or prod.',
        );
    }
  }

  bool get isDev => this == Flavor.dev;
  bool get isUat => this == Flavor.uat;
  bool get isProd => this == Flavor.prod;
}
