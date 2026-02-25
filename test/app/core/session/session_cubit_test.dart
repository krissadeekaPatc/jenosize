import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/storages/app_storage.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

class FakeUser extends Fake implements User {}

void main() {
  late MockAppStorage mockAppStorage;

  final mockUser = const User(
    id: 'user_123',
    firstName: 'Nk',
    lastName: 'Pz',
    totalPoints: 500,
  );

  final mockPointHistory = PointHistory(
    id: 'hist_1',
    points: 100,
    title: 'Welcome Bonus',
    createdAt: DateTime.now(),
  );

  setUpAll(() {
    registerFallbackValue(FakeUser());
  });

  setUp(() {
    mockAppStorage = MockAppStorage();

    when(
      () => mockAppStorage.getObject<User>(
        any(),
        fromJson: any(named: 'fromJson'),
      ),
    ).thenAnswer((_) async => null);

    when(() => mockAppStorage.getJson(any())).thenAnswer((_) async => null);
    when(() => mockAppStorage.remove(any())).thenAnswer((_) async {});
    when(() => mockAppStorage.setJson(any(), any())).thenAnswer((_) async {});
  });

  group('SessionCubit Initialization', () {
    blocTest<SessionCubit, SessionState>(
      'emits cleared state when initialized with no user in storage',
      build: () => SessionCubit(appStorage: mockAppStorage),
      act: (cubit) async => await Future.delayed(Duration.zero),
      verify: (_) {
        verify(() => mockAppStorage.remove(StorageKey.user.name)).called(1);
        verify(
          () => mockAppStorage.remove(StorageKey.pointHistory.name),
        ).called(1);
        verify(
          () => mockAppStorage.remove(StorageKey.joinedCampaignIds.name),
        ).called(1);
      },
    );
    blocTest<SessionCubit, SessionState>(
      'loads joined campaigns from storage on initialization',
      setUp: () {
        when(
          () => mockAppStorage.getObject<User>(
            StorageKey.user.name,
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => mockUser);

        when(
          () => mockAppStorage.getJson(StorageKey.joinedCampaignIds.name),
        ).thenAnswer(
          (_) async => {
            'ids': ['camp_1', 'camp_2'],
          },
        );
      },
      build: () => SessionCubit(appStorage: mockAppStorage),
      act: (cubit) async => await Future.delayed(Duration.zero),
      expect: () => [
        SessionState(user: mockUser),
        SessionState(
          user: mockUser,
          joinedCampaignIds: const {'camp_1', 'camp_2'},
        ),
      ],
    );
  });

  group('SessionCubit setUser', () {
    blocTest<SessionCubit, SessionState>(
      'emits state with user and saves to storage when valid user is set',
      build: () => SessionCubit(appStorage: mockAppStorage),
      skip: 1,
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        cubit.setUser(mockUser);
      },
      expect: () => [
        SessionState(user: mockUser),
      ],
      verify: (_) {
        verify(
          () => mockAppStorage.setJson(StorageKey.user.name, mockUser.toJson()),
        ).called(1);
      },
    );

    blocTest<SessionCubit, SessionState>(
      'clears data when null user is set',
      setUp: () {
        when(
          () => mockAppStorage.getObject<User>(
            any(),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => mockUser);
      },
      build: () => SessionCubit(appStorage: mockAppStorage),
      skip: 1,
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        cubit.setUser(null);
      },
      expect: () => [
        const SessionState(),
      ],
      verify: (_) {
        verify(
          () => mockAppStorage.remove(StorageKey.user.name),
        ).called(greaterThanOrEqualTo(1));
      },
    );
  });

  group('SessionCubit Point Histories', () {
    blocTest<SessionCubit, SessionState>(
      'does nothing when setPointHistories is called but user is null',
      build: () => SessionCubit(appStorage: mockAppStorage),
      skip: 1,
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        cubit.setPointHistories([mockPointHistory]);
      },
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockAppStorage.setJson(any(), any()));
      },
    );

    blocTest<SessionCubit, SessionState>(
      'emits updated histories and saves to storage when user is present',
      setUp: () {
        when(
          () => mockAppStorage.getObject<User>(
            any(),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => mockUser);
      },
      build: () => SessionCubit(appStorage: mockAppStorage),
      skip: 1,
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        cubit.setPointHistories([mockPointHistory]);
      },
      expect: () => [
        SessionState(user: mockUser, pointHistories: [mockPointHistory]),
      ],
      verify: (_) {
        verify(
          () => mockAppStorage.setJson(
            StorageKey.pointHistory.name,
            {
              'data': [mockPointHistory.toJson()],
            },
          ),
        ).called(1);
      },
    );

    blocTest<SessionCubit, SessionState>(
      'adds new history to the top of the list when addPointHistory is called',
      setUp: () {
        when(
          () => mockAppStorage.getObject<User>(
            any(),
            fromJson: any(named: 'fromJson'),
          ),
        ).thenAnswer((_) async => mockUser);
        when(
          () => mockAppStorage.getJson(StorageKey.pointHistory.name),
        ).thenAnswer(
          (_) async => {
            'data': [mockPointHistory.toJson()],
          },
        );
      },
      build: () => SessionCubit(appStorage: mockAppStorage),
      skip: 2,
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        final newHistory = const PointHistory(id: 'hist_2', points: 50);
        cubit.addPointHistory(newHistory);
      },
      expect: () => [
        isA<SessionState>()
            .having((s) => s.pointHistories.length, 'histories length', 2)
            .having(
              (s) => s.pointHistories.firstOrNull?.id,
              'first history is the new one',
              'hist_2',
            ),
      ],
    );
  });

  group('SessionCubit Joined Campaigns', () {
    blocTest<SessionCubit, SessionState>(
      'adds campaign ID to set and saves to storage',
      build: () => SessionCubit(appStorage: mockAppStorage),
      skip: 1,
      act: (cubit) async {
        await Future.delayed(Duration.zero);
        cubit.addJoinedCampaign('campaign_1');
      },
      expect: () => [
        const SessionState(joinedCampaignIds: {'campaign_1'}),
      ],
      verify: (_) {
        verify(
          () => mockAppStorage.setJson(
            StorageKey.joinedCampaignIds.name,
            {
              'ids': ['campaign_1'],
            },
          ),
        ).called(1);
      },
    );
  });
}
