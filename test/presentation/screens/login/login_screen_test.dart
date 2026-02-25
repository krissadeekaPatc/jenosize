import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jenosize/common/app_language.dart';
import 'package:jenosize/generated/app_localizations.dart';
import 'package:jenosize/ui/cubits/app_language_cubit.dart';
import 'package:jenosize/ui/global_widgets/loading_overlay.dart';
import 'package:jenosize/ui/screens/login/cubit/login_screen_cubit.dart';
import 'package:jenosize/ui/screens/login/cubit/login_screen_state.dart';
import 'package:jenosize/ui/screens/login/login_screen.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

class MockLoginScreenCubit extends MockCubit<LoginScreenState>
    implements LoginScreenCubit {}

void main() {
  late MockLoginScreenCubit mockLoginCubit;
  late MockAppLanguageCubit mockLanguageCubit;

  setUpAll(() {
    registerFallbackValue(AppLanguage.en);
  });

  setUp(() {
    mockLoginCubit = MockLoginScreenCubit();
    mockLanguageCubit = MockAppLanguageCubit();

    when(() => mockLoginCubit.state).thenReturn(const LoginScreenState());
    when(() => mockLanguageCubit.state).thenReturn(AppLanguage.en);
    when(() => mockLoginCubit.login(any(), any())).thenAnswer((_) async {});
    when(() => mockLanguageCubit.setLanguage(any())).thenAnswer((_) async {});
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginScreenCubit>.value(value: mockLoginCubit),
        BlocProvider<AppLanguageCubit>.value(value: mockLanguageCubit),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: body,
      ),
    );
  }

  /*
   * LoginScreenView Widget Test Cases:
   * 1. UI Rendering: ตรวจสอบว่าหน้าจอแสดงผลองค์ประกอบหลักครบถ้วน (TextFormField 2 ช่อง, FilledButton 1 ปุ่ม, TextButton 1 ปุ่ม)
   * 2. Empty Field Validation: ตรวจสอบระบบป้องกันเมื่อกรอกข้อมูลว่าง (ไม่พบ SnackBar และ Cubit ต้องไม่ถูกเรียก)
   * 3. Invalid Email Format: ตรวจสอบระบบป้องกันเมื่อกรอกอีเมลผิดรูปแบบ (Cubit ต้องไม่ถูกเรียก)
   * 4. Valid Submission: ตรวจสอบการส่งข้อมูล (เมื่อข้อมูลถูกต้อง ต้องเรียก Cubit.login พร้อมค่าที่กรอก)
   * 5. Language Toggle: ตรวจสอบการกดปุ่มเปลี่ยนภาษา (ต้องเรียก Cubit.setLanguage)
   * 6. Loading State: ตรวจสอบสถานะโหลด (ต้องแสดง LoadingIndicator เมื่อ State คือ loading)
   */
  group('LoginScreenView Widget Tests', () {
    testWidgets('renders all essential UI components', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets(
      'shows validation errors and does not call login when fields are empty',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsNothing);
        verifyNever(() => mockLoginCubit.login(any(), any()));
      },
    );

    testWidgets(
      'shows validation error and does not call login when email format is invalid',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

        final textFields = find.byType(TextFormField);
        final emailField = textFields.first;
        final passwordField = textFields.last;

        await tester.enterText(emailField, 'wrong-email-format');
        await tester.enterText(passwordField, 'password123');

        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();

        verifyNever(() => mockLoginCubit.login(any(), any()));
      },
    );

    testWidgets(
      'calls login on cubit when fields are valid and button is pressed',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

        final textFields = find.byType(TextFormField);
        final emailField = textFields.first;
        final passwordField = textFields.last;

        await tester.enterText(emailField, 'test@jenosize.com');
        await tester.enterText(passwordField, 'password123');

        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        verify(
          () => mockLoginCubit.login('test@jenosize.com', 'password123'),
        ).called(1);
      },
    );

    testWidgets('toggles language when language button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

      await tester.tap(find.byType(TextButton));
      await tester.pump();

      verify(() => mockLanguageCubit.setLanguage(AppLanguage.th)).called(1);
    });

    testWidgets('shows LoadingOverlay when state is loading', (tester) async {
      when(
        () => mockLoginCubit.state,
      ).thenReturn(const LoginScreenState().loading());

      await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });
  });
}
