import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/ui/screens/main/cubit/main_screen_state.dart';
import 'package:jenosize/ui/screens/main/main_screen_tab.dart';

void main() {
  /*
   * MainScreenState Test Cases:
   * 1. Value Equality: ตรวจสอบว่า Equatable ทำงานถูกต้อง (State ที่มี selectedTab เดียวกันต้องถือว่าเท่ากัน)
   * 2. Props: ตรวจสอบว่า getter props ส่งค่า selectedTab ออกมาถูกต้อง
   * 3. copyWith: ตรวจสอบว่าสามารถอัปเดต selectedTab ได้ถูกต้อง และคืนค่าเดิมหากไม่ได้ส่งพารามิเตอร์มา
   */
  group('MainScreenState', () {
    test('supports value equality', () {
      expect(
        const MainScreenState(),
        equals(const MainScreenState()),
      );

      expect(
        const MainScreenState(selectedTab: MainScreenTab.pointTrack),
        isNot(equals(const MainScreenState(selectedTab: MainScreenTab.home))),
      );
    });

    test('props are correct', () {
      expect(
        const MainScreenState(selectedTab: MainScreenTab.home).props,
        equals([MainScreenTab.home]),
      );
    });

    group('copyWith', () {
      test('returns same object with updated selectedTab', () {
        final state = const MainScreenState(selectedTab: MainScreenTab.home);
        final newState = state.copyWith(selectedTab: MainScreenTab.pointTrack);

        expect(newState.selectedTab, equals(MainScreenTab.pointTrack));
      });

      test('returns same object when no arguments are provided', () {
        final state = const MainScreenState(
          selectedTab: MainScreenTab.pointTrack,
        );
        final newState = state.copyWith();

        expect(newState.selectedTab, equals(MainScreenTab.pointTrack));
      });
    });
  });
}
