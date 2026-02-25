// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get login_error_empty_fields => 'กรุณากรอกอีเมลและรหัสผ่าน';

  @override
  String get login_welcome_back => 'ยินดีต้อนรับกลับเข้าสู่ระบบ';

  @override
  String get login_sign_in_to_continue => 'เข้าสู่ระบบเพื่อดำเนินการต่อ';

  @override
  String get login_label_email => 'อีเมล';

  @override
  String get login_label_password => 'รหัสผ่าน';

  @override
  String get login_button_submit => 'เข้าสู่ระบบ';

  @override
  String get error_title => 'ขออภัย';

  @override
  String get common_ok => 'ตกลง';

  @override
  String get common_cancel => 'ยกเลิก';

  @override
  String get home_title_campaigns => 'แคมเปญ';

  @override
  String get home_error_load_failed => 'ไม่สามารถโหลดข้อมูลแคมเปญได้';

  @override
  String get home_empty_campaigns => 'ยังไม่มีแคมเปญในขณะนี้';

  @override
  String get common_points_suffix => 'คะแนน';

  @override
  String get home_button_join_now => 'เข้าร่วมเลย';

  @override
  String get home_button_joined => 'เข้าร่วมแล้ว';

  @override
  String get point_track_title => 'ประวัติคะแนน';

  @override
  String get point_track_total_balance => 'คะแนนคงเหลือทั้งหมด';

  @override
  String get point_track_unit_points => 'คะแนน';

  @override
  String get point_track_empty_transactions => 'ยังไม่มีรายการประวัติคะแนน';

  @override
  String get membership_title => 'สมาชิก';

  @override
  String membership_welcome_back(Object name) {
    return 'ยินดีต้อนรับกลับมาครับคุณ $name! ✨';
  }

  @override
  String get membership_join_promo =>
      'สมัครสมาชิกวันนี้เพื่อรับ 100 คะแนน และแชร์รหัสแนะนำเพื่อน!';

  @override
  String get membership_button_join => 'สมัครสมาชิกเลย';

  @override
  String get membership_status_premium => 'สมาชิกระดับพรีเมียม';

  @override
  String get membership_refer_title => 'แนะนำเพื่อน';

  @override
  String get membership_refer_desc =>
      'ชวนเพื่อนของคุณมาสมัครสมาชิกเพื่อรับคะแนนเพิ่ม!';

  @override
  String get membership_copy_success => 'คัดลอกไปยังคลิปบอร์ดแล้ว';

  @override
  String membership_share_text(Object code) {
    return 'มาเป็นสมาชิก Jenosize กับเราเถอะ! ใช้รหัสของฉันนะ: $code';
  }

  @override
  String get membership_button_share => 'แชร์รหัสแนะนำเพื่อน';

  @override
  String get settings_title => 'ตั้งค่า';

  @override
  String get settings_section_appearance => 'รูปแบบ';

  @override
  String get settings_section_account => 'บัญชี';

  @override
  String get settings_theme_system => 'ตามระบบ';

  @override
  String get settings_theme_light => 'โหมดสว่าง';

  @override
  String get settings_theme_dark => 'โหมดมืด';

  @override
  String get settings_button_logout => 'ออกจากระบบ';

  @override
  String settings_version_label(Object version) {
    return 'เวอร์ชัน $version';
  }

  @override
  String get settings_section_language => 'ภาษา';

  @override
  String get settings_language_en => 'อังกฤษ';

  @override
  String get settings_language_th => 'ไทย';

  @override
  String get home_alert_join_title => 'เข้าร่วมแคมเปญ';

  @override
  String get home_alert_join_message =>
      'คุณยืนยันที่จะเข้าร่วมแคมเปญนี้ใช่หรือไม่?';
}
