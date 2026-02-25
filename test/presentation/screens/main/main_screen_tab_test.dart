import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/ui/screens/main/main_screen_tab.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext mockContext;

  setUp(() {
    mockContext = MockBuildContext();
  });

  /*
   * MainScreenTab Unit Test Cases:
   * 1. Icon Mapping: ตรวจสอบว่าแต่ละ Tab คืนค่า IconData (Outline) ได้ถูกต้อง
   * 2. Selected Icon Mapping: ตรวจสอบว่าแต่ละ Tab คืนค่า IconData (Rounded) เมื่ออยู่ในสถานะถูกเลือกได้ถูกต้อง
   */
  group('MainScreenTab Unit Tests', () {
    test('returns correct outline icons', () {
      expect(MainScreenTab.home.icon(mockContext), Icons.home_outlined);
      expect(MainScreenTab.pointTrack.icon(mockContext), Icons.stars_outlined);
      expect(
        MainScreenTab.membership.icon(mockContext),
        Icons.card_membership_outlined,
      );
      expect(MainScreenTab.setting.icon(mockContext), Icons.settings_outlined);
    });

    test('returns correct rounded icons when selected', () {
      expect(MainScreenTab.home.iconSelected(mockContext), Icons.home_rounded);
      expect(
        MainScreenTab.pointTrack.iconSelected(mockContext),
        Icons.stars_rounded,
      );
      expect(
        MainScreenTab.membership.iconSelected(mockContext),
        Icons.card_membership_rounded,
      );
      expect(
        MainScreenTab.setting.iconSelected(mockContext),
        Icons.settings_rounded,
      );
    });
  });
}
