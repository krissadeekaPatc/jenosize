import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_state.dart';

void main() {
  /*
   * HomeScreenState Unit Test Cases:
   * 1. Equality: ตรวจสอบว่า Equatable ทำงานถูกต้อง เมื่อค่าเหมือนกัน Object ต้องเท่ากัน
   * 2. copyWith: ตรวจสอบการเปลี่ยนค่าเฉพาะบาง Field และการคงค่าเดิมไว้
   * 3. status.isLoading: ตรวจสอบ Getter ใน enum ว่าทำงานถูกต้อง
   * 4. Helper Methods: ตรวจสอบ loading(), ready(), และ failure() ว่าเปลี่ยน Status และข้อมูลได้ถูกต้อง
   */
  group('HomeScreenState', () {
    test('supports value equality', () {
      expect(
        const HomeScreenState(),
        equals(const HomeScreenState()),
      );
    });

    test('props are correct', () {
      const error = AppError(message: 'error');
      const campaigns = [Campaign(id: '1')];

      expect(
        const HomeScreenState(
          status: HomeScreenStatus.initial,
          error: error,
          campaigns: campaigns,
        ).props,
        equals([
          HomeScreenStatus.initial,
          campaigns,
          error,
        ]),
      );
    });

    group('copyWith', () {
      test('returns same object when no arguments are provided', () {
        expect(
          const HomeScreenState().copyWith(),
          equals(const HomeScreenState()),
        );
      });

      test('retains old values when other fields are updated', () {
        const state = HomeScreenState(status: HomeScreenStatus.loading);
        const campaigns = [Campaign(id: '1')];

        expect(
          state.copyWith(campaigns: campaigns),
          equals(
            const HomeScreenState(
              status: HomeScreenStatus.loading,
              campaigns: campaigns,
            ),
          ),
        );
      });
    });

    group('HomeScreenStatus', () {
      test('isLoading returns true only when status is loading', () {
        expect(HomeScreenStatus.initial.isLoading, isFalse);
        expect(HomeScreenStatus.loading.isLoading, isTrue);
        expect(HomeScreenStatus.ready.isLoading, isFalse);
        expect(HomeScreenStatus.failure.isLoading, isFalse);
      });
    });

    group('Helper Methods', () {
      test('loading() emits loading status', () {
        expect(
          const HomeScreenState().loading(),
          equals(const HomeScreenState(status: HomeScreenStatus.loading)),
        );
      });

      test('ready() emits ready status with campaigns', () {
        const campaigns = [Campaign(id: '1')];
        expect(
          const HomeScreenState().ready(campaigns: campaigns),
          equals(
            const HomeScreenState(
              status: HomeScreenStatus.ready,
              campaigns: campaigns,
            ),
          ),
        );
      });

      test('failure() emits failure status with error', () {
        const error = AppError(message: 'some error');
        expect(
          const HomeScreenState().failure(error),
          equals(
            const HomeScreenState(
              status: HomeScreenStatus.failure,
              error: error,
            ),
          ),
        );
      });
    });
  });
}
