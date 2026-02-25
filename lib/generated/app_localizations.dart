import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// No description provided for @login_error_empty_fields.
  ///
  /// In en, this message translates to:
  /// **'Please enter both email and password.'**
  String get login_error_empty_fields;

  /// No description provided for @login_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get login_welcome_back;

  /// No description provided for @login_sign_in_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get login_sign_in_to_continue;

  /// No description provided for @login_label_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_label_email;

  /// No description provided for @login_label_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_label_password;

  /// No description provided for @login_button_submit.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login_button_submit;

  /// No description provided for @error_title.
  ///
  /// In en, this message translates to:
  /// **'Sorry'**
  String get error_title;

  /// No description provided for @common_ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get common_ok;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @home_title_campaigns.
  ///
  /// In en, this message translates to:
  /// **'Campaigns'**
  String get home_title_campaigns;

  /// No description provided for @home_error_load_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load campaigns'**
  String get home_error_load_failed;

  /// No description provided for @home_empty_campaigns.
  ///
  /// In en, this message translates to:
  /// **'No campaigns available'**
  String get home_empty_campaigns;

  /// No description provided for @common_points_suffix.
  ///
  /// In en, this message translates to:
  /// **'Pts'**
  String get common_points_suffix;

  /// No description provided for @home_button_join_now.
  ///
  /// In en, this message translates to:
  /// **'Join Now'**
  String get home_button_join_now;

  /// No description provided for @home_button_joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get home_button_joined;

  /// No description provided for @point_track_title.
  ///
  /// In en, this message translates to:
  /// **'Point History'**
  String get point_track_title;

  /// No description provided for @point_track_total_balance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get point_track_total_balance;

  /// No description provided for @point_track_unit_points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get point_track_unit_points;

  /// No description provided for @point_track_empty_transactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet.'**
  String get point_track_empty_transactions;

  /// No description provided for @membership_title.
  ///
  /// In en, this message translates to:
  /// **'Membership'**
  String get membership_title;

  /// No description provided for @membership_welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}! ✨'**
  String membership_welcome_back(Object name);

  /// No description provided for @membership_join_promo.
  ///
  /// In en, this message translates to:
  /// **'Join our membership to get 100 points and share referral codes!'**
  String get membership_join_promo;

  /// No description provided for @membership_button_join.
  ///
  /// In en, this message translates to:
  /// **'Join Now'**
  String get membership_button_join;

  /// No description provided for @membership_status_premium.
  ///
  /// In en, this message translates to:
  /// **'Premium Member'**
  String get membership_status_premium;

  /// No description provided for @membership_refer_title.
  ///
  /// In en, this message translates to:
  /// **'Refer-a-Friend'**
  String get membership_refer_title;

  /// No description provided for @membership_refer_desc.
  ///
  /// In en, this message translates to:
  /// **'Invite your friends to join and earn more points!'**
  String get membership_refer_desc;

  /// No description provided for @membership_copy_success.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get membership_copy_success;

  /// No description provided for @membership_share_text.
  ///
  /// In en, this message translates to:
  /// **'Join me on Jenosize! Use my code: {code}'**
  String membership_share_text(Object code);

  /// No description provided for @membership_button_share.
  ///
  /// In en, this message translates to:
  /// **'Share referral code'**
  String get membership_button_share;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_section_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_section_appearance;

  /// No description provided for @settings_section_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settings_section_account;

  /// No description provided for @settings_theme_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settings_theme_system;

  /// No description provided for @settings_theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_light;

  /// No description provided for @settings_theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_dark;

  /// No description provided for @settings_button_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settings_button_logout;

  /// No description provided for @settings_version_label.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settings_version_label(Object version);

  /// No description provided for @settings_section_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_section_language;

  /// No description provided for @settings_language_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_language_en;

  /// No description provided for @settings_language_th.
  ///
  /// In en, this message translates to:
  /// **'Thai'**
  String get settings_language_th;

  /// No description provided for @home_alert_join_title.
  ///
  /// In en, this message translates to:
  /// **'Join Campaign'**
  String get home_alert_join_title;

  /// No description provided for @home_alert_join_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to join this campaign?'**
  String get home_alert_join_message;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
