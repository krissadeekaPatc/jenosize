// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_error_empty_fields =>
      'Please enter both email and password.';

  @override
  String get login_welcome_back => 'Welcome Back';

  @override
  String get login_sign_in_to_continue => 'Sign in to continue';

  @override
  String get login_label_email => 'Email';

  @override
  String get login_label_password => 'Password';

  @override
  String get login_button_submit => 'Login';

  @override
  String get error_title => 'Sorry';

  @override
  String get common_ok => 'OK';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get home_title_campaigns => 'Campaigns';

  @override
  String get home_error_load_failed => 'Failed to load campaigns';

  @override
  String get home_empty_campaigns => 'No campaigns available';

  @override
  String get common_points_suffix => 'Pts';

  @override
  String get home_button_join_now => 'Join Now';

  @override
  String get home_button_joined => 'Joined';

  @override
  String get point_track_title => 'Point History';

  @override
  String get point_track_total_balance => 'Total Balance';

  @override
  String get point_track_unit_points => 'Points';

  @override
  String get point_track_empty_transactions => 'No transactions yet.';

  @override
  String get membership_title => 'Membership';

  @override
  String membership_welcome_back(Object name) {
    return 'Welcome back, $name! ✨';
  }

  @override
  String get membership_join_promo =>
      'Join our membership to get 100 points and share referral codes!';

  @override
  String get membership_button_join => 'Join Now';

  @override
  String get membership_status_premium => 'Premium Member';

  @override
  String get membership_refer_title => 'Refer-a-Friend';

  @override
  String get membership_refer_desc =>
      'Invite your friends to join and earn more points!';

  @override
  String get membership_copy_success => 'Copied to clipboard';

  @override
  String membership_share_text(Object code) {
    return 'Join me on Jenosize! Use my code: $code';
  }

  @override
  String get membership_button_share => 'Share referral code';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_section_appearance => 'Appearance';

  @override
  String get settings_section_account => 'Account';

  @override
  String get settings_theme_system => 'System';

  @override
  String get settings_theme_light => 'Light';

  @override
  String get settings_theme_dark => 'Dark';

  @override
  String get settings_button_logout => 'Logout';

  @override
  String settings_version_label(Object version) {
    return 'Version $version';
  }

  @override
  String get settings_section_language => 'Language';

  @override
  String get settings_language_en => 'English';

  @override
  String get settings_language_th => 'Thai';

  @override
  String get home_alert_join_title => 'Join Campaign';

  @override
  String get home_alert_join_message =>
      'Are you sure you want to join this campaign?';
}
