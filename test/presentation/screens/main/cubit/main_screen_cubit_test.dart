import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/ui/screens/main/cubit/main_screen_cubit.dart';
import 'package:jenosize/ui/screens/main/cubit/main_screen_state.dart';
import 'package:jenosize/ui/screens/main/main_screen_tab.dart';

void main() {
  /*
   * MainScreenCubit Test Cases:
   * 1. Change Tab: ตรวจสอบว่าเมื่อเรียก changeTab ไปยัง Tab ที่ต้องการ 
   * State จะต้องอัปเดตค่า selectedTab ให้ถูกต้องตามที่ส่งไป
   */
  group('MainScreenCubit', () {
    blocTest<MainScreenCubit, MainScreenState>(
      'emits updated selectedTab when changeTab is called',
      build: () => MainScreenCubit(),
      act: (cubit) => cubit.changeTab(MainScreenTab.pointTrack),
      expect: () => [
        const MainScreenState(selectedTab: MainScreenTab.pointTrack),
      ],
    );

    blocTest<MainScreenCubit, MainScreenState>(
      'emits another tab correctly when changed multiple times',
      build: () => MainScreenCubit(),
      act: (cubit) {
        cubit.changeTab(MainScreenTab.pointTrack);
        cubit.changeTab(MainScreenTab.home);
      },
      expect: () => [
        const MainScreenState(selectedTab: MainScreenTab.pointTrack),
        const MainScreenState(selectedTab: MainScreenTab.home),
      ],
    );
  });
}
