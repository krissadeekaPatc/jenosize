import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/core/app_error.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_cubit.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  late HomeScreenCubit cubit;
  late MockCampaignRepository mockCampaignRepository;
  late MockSessionCubit mockSessionCubit;

  const testUser = User(id: 'user_123', totalPoints: 100);
  const testCampaign = Campaign(
    id: 'camp_001',
    title: 'Test Campaign',
    pointsReward: 50,
  );
  const campaignsList = [testCampaign];

  setUp(() {
    mockCampaignRepository = MockCampaignRepository();
    mockSessionCubit = MockSessionCubit();

    when(() => mockSessionCubit.state).thenReturn(
      const SessionState(user: testUser),
    );
    when(() => mockSessionCubit.stream).thenAnswer((_) => const Stream.empty());

    cubit = HomeScreenCubit(
      campaignRepository: mockCampaignRepository,
      sessionCubit: mockSessionCubit,
    );
  });

  /*
   * HomeScreenCubit Unit Test Cases:
   * 1. Initial State: ตรวจสอบสถานะเริ่มต้นของ Cubit ว่าถูกต้องหรือไม่
   * 2. Load Campaigns Success: ตรวจสอบการโหลดข้อมูลสำเร็จและแสดงรายการ Campaign
   * 3. Load Campaigns Failure: ตรวจสอบการจัดการเมื่อการโหลดข้อมูลล้มเหลว
   * 4. Join Campaign Validation: ตรวจสอบว่าระบบไม่ทำงานเมื่อข้อมูลผู้ใช้หรือ Campaign ไม่ครบถ้วน
   * 5. Join Campaign Success: ตรวจสอบการเพิ่มแต้มและอัปเดตสถานะเมื่อเข้าร่วมสำเร็จ
   * 6. Join Campaign Failure: ตรวจสอบการแจ้งเตือนเมื่อการเข้าร่วมล้มเหลว
   */

  group('HomeScreenCubit', () {
    test('initial state should be correct', () {
      expect(cubit.state, const HomeScreenState());
    });

    group('loadCampaigns', () {
      blocTest<HomeScreenCubit, HomeScreenState>(
        'emits [loading, ready] when getCampaigns is successful',
        build: () {
          when(() => mockCampaignRepository.getCampaigns()).thenAnswer(
            (_) async => const Success(campaignsList),
          );
          return cubit;
        },
        act: (cubit) => cubit.loadCampaigns(),
        expect: () => [
          const HomeScreenState(status: HomeScreenStatus.loading),
          const HomeScreenState(
            status: HomeScreenStatus.ready,
            campaigns: campaignsList,
          ),
        ],
      );

      blocTest<HomeScreenCubit, HomeScreenState>(
        'emits [loading, failure] when getCampaigns fails',
        build: () {
          when(() => mockCampaignRepository.getCampaigns()).thenAnswer(
            (_) async => const Failure(AppError(message: 'Error')),
          );
          return cubit;
        },
        act: (cubit) => cubit.loadCampaigns(),
        expect: () => [
          const HomeScreenState(status: HomeScreenStatus.loading),
          isA<HomeScreenState>().having(
            (s) => s.status,
            'status',
            HomeScreenStatus.failure,
          ),
        ],
      );
    });

    group('joinCampaign', () {
      blocTest<HomeScreenCubit, HomeScreenState>(
        'does nothing if campaign or user is null',
        build: () {
          when(() => mockSessionCubit.state).thenReturn(
            const SessionState(user: null),
          );
          return cubit;
        },
        act: (cubit) => cubit.joinCampaign(testCampaign),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockCampaignRepository.joinCampaign(any()));
        },
      );

      blocTest<HomeScreenCubit, HomeScreenState>(
        'emits [loading, ready] and updates session when join is successful',
        build: () {
          when(() => mockCampaignRepository.joinCampaign(any())).thenAnswer(
            (_) async => Success(Unit()),
          );
          when(
            () => mockSessionCubit.addJoinedCampaign(any()),
          ).thenReturn(null);
          when(() => mockSessionCubit.addPointHistory(any())).thenReturn(null);
          when(() => mockSessionCubit.setUser(any())).thenReturn(null);
          return cubit;
        },
        act: (cubit) => cubit.joinCampaign(testCampaign),
        expect: () => [
          const HomeScreenState(status: HomeScreenStatus.loading),
          const HomeScreenState(status: HomeScreenStatus.ready),
        ],
        verify: (_) {
          verify(
            () => mockCampaignRepository.joinCampaign(testCampaign.id!),
          ).called(1);
          verify(
            () => mockSessionCubit.setUser(
              any(
                that: isA<User>().having(
                  (u) => u.totalPoints,
                  'totalPoints',
                  150,
                ),
              ),
            ),
          ).called(1);
        },
      );

      blocTest<HomeScreenCubit, HomeScreenState>(
        'emits [loading, failure] when join fails',
        build: () {
          when(() => mockCampaignRepository.joinCampaign(any())).thenAnswer(
            (_) async => const Failure(AppError(message: 'Join Failed')),
          );
          return cubit;
        },
        act: (cubit) => cubit.joinCampaign(testCampaign),
        expect: () => [
          const HomeScreenState(status: HomeScreenStatus.loading),
          isA<HomeScreenState>().having(
            (s) => s.status,
            'status',
            HomeScreenStatus.failure,
          ),
        ],
      );
    });
    group('HomeScreenCubit', () {
      test('initial state should be correct', () {
        expect(cubit.state, const HomeScreenState());
      });

      group('loadCampaigns', () {
        blocTest<HomeScreenCubit, HomeScreenState>(
          'emits [loading, ready] when getCampaigns is successful',
          build: () {
            when(() => mockCampaignRepository.getCampaigns()).thenAnswer(
              (_) async => const Success(campaignsList),
            );
            return cubit;
          },
          act: (cubit) => cubit.loadCampaigns(),
          expect: () => [
            const HomeScreenState(status: HomeScreenStatus.loading),
            const HomeScreenState(
              status: HomeScreenStatus.ready,
              campaigns: campaignsList,
            ),
          ],
        );

        blocTest<HomeScreenCubit, HomeScreenState>(
          'emits [loading, failure] when getCampaigns fails',
          build: () {
            when(() => mockCampaignRepository.getCampaigns()).thenAnswer(
              (_) async => const Failure(AppError(message: 'Error')),
            );
            return cubit;
          },
          act: (cubit) => cubit.loadCampaigns(),
          expect: () => [
            const HomeScreenState(status: HomeScreenStatus.loading),
            isA<HomeScreenState>().having(
              (s) => s.status,
              'status',
              HomeScreenStatus.failure,
            ),
          ],
        );
      });

      group('joinCampaign', () {
        blocTest<HomeScreenCubit, HomeScreenState>(
          'emits [loading, ready] and updates session when join is successful',
          build: () {
            when(() => mockCampaignRepository.joinCampaign(any())).thenAnswer(
              (_) async => Success(Unit()),
            );
            when(
              () => mockSessionCubit.addJoinedCampaign(any()),
            ).thenReturn(null);
            when(
              () => mockSessionCubit.addPointHistory(any()),
            ).thenReturn(null);
            when(() => mockSessionCubit.setUser(any())).thenReturn(null);
            return cubit;
          },
          act: (cubit) => cubit.joinCampaign(testCampaign),
          expect: () => [
            const HomeScreenState(status: HomeScreenStatus.loading),
            const HomeScreenState(status: HomeScreenStatus.ready),
          ],
          verify: (_) {
            verify(
              () => mockCampaignRepository.joinCampaign(testCampaign.id!),
            ).called(1);
            verify(
              () => mockSessionCubit.setUser(
                any(
                  that: isA<User>().having(
                    (u) => u.totalPoints,
                    'totalPoints',
                    150,
                  ),
                ),
              ),
            ).called(1);
          },
        );
      });
    });
  });
}
