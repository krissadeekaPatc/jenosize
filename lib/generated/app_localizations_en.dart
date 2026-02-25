// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get error_title => 'Sorry';

  @override
  String new_version_available_dialog_message(Object version) {
    return 'Please update to the latest version $version';
  }

  @override
  String get new_version_available_dialog_title => 'New Version Available';

  @override
  String get dashboard_screen_tab_home => 'Home';

  @override
  String get dashboard_screen_tab_settings => 'Settings';
}
