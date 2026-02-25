import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/generated/app_localizations.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';
import 'package:jenosize/ui/global_widgets/campaign_card.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_cubit.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_state.dart';
import 'package:jenosize/ui/screens/home/home_screen.dart';
import 'package:jenosize/ui/styles/app_colors.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

class MockHomeScreenCubit extends Mock implements HomeScreenCubit {}

void main() {
  late MockHomeScreenCubit mockHomeCubit;
  late MockSessionCubit mockSessionCubit;

  final testCampaigns = [
    const Campaign(id: '1', title: 'Campaign 1'),
    const Campaign(id: '2', title: 'Campaign 2'),
  ];

  setUp(() {
    mockHomeCubit = MockHomeScreenCubit();
    mockSessionCubit = MockSessionCubit();

    when(() => mockSessionCubit.state).thenReturn(const SessionState());
    when(() => mockSessionCubit.stream).thenAnswer((_) => const Stream.empty());

    when(() => mockHomeCubit.state).thenReturn(const HomeScreenState());
    when(() => mockHomeCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockHomeCubit.loadCampaigns()).thenAnswer((_) async {});
  });

  Widget makeTestableWidget() {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        extensions: const [
          AppColors(
            cautionary: Colors.yellow,
            negative: Colors.red,
            positive: Colors.green,
            inactive: Colors.grey,
            success: Color(0xFF2E7D32),
            failed: Color(0xFFD32F2F),
            warning: Color(0xFFFFA000),
            info: Color(0xFF1976D2),
          ),
        ],
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<HomeScreenCubit>.value(value: mockHomeCubit),
          BlocProvider<SessionCubit>.value(value: mockSessionCubit),
        ],
        child: const Scaffold(
          body: HomeScreenView(),
        ),
      ),
    );
  }

  group('HomeScreenView Widget Tests', () {
    testWidgets('triggers loadCampaigns on initState', (tester) async {
      await tester.pumpWidget(makeTestableWidget());
      verify(() => mockHomeCubit.loadCampaigns()).called(1);
    });

    testWidgets('shows empty state message when campaigns list is empty', (
      tester,
    ) async {
      when(
        () => mockHomeCubit.state,
      ).thenReturn(const HomeScreenState(campaigns: []));

      await tester.pumpWidget(makeTestableWidget());

      expect(
        find.text('No campaigns available'),
        findsOneWidget,
      );
    });

    testWidgets('renders list of CampaignCards when campaigns are available', (
      tester,
    ) async {
      when(() => mockHomeCubit.state).thenReturn(
        HomeScreenState(
          status: HomeScreenStatus.ready,
          campaigns: testCampaigns,
        ),
      );

      await tester.pumpWidget(makeTestableWidget());

      expect(find.byType(CampaignCard), findsNWidgets(2));
      expect(find.text('Campaign 1'), findsOneWidget);
      expect(find.text('Campaign 2'), findsOneWidget);
    });

    testWidgets('marks CampaignCard as joined if ID exists in SessionState', (
      tester,
    ) async {
      when(() => mockHomeCubit.state).thenReturn(
        HomeScreenState(
          status: HomeScreenStatus.ready,
          campaigns: testCampaigns,
        ),
      );
      when(() => mockSessionCubit.state).thenReturn(
        const SessionState(joinedCampaignIds: {'1'}),
      );

      await tester.pumpWidget(makeTestableWidget());

      final firstCard = tester.widget<CampaignCard>(
        find.byType(CampaignCard).first,
      );
      expect(firstCard.isJoined, isTrue);

      final secondCard = tester.widget<CampaignCard>(
        find.byType(CampaignCard).last,
      );
      expect(secondCard.isJoined, isFalse);
    });
  });
}
