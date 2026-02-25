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
   * 1. UI Rendering: ตรวจสอบว่าหน้าจอแสดงผลองค์ประกอบหลักครบถ้วน (ช่องกรอก Email/Password 2 ช่อง, ปุ่ม Login 1 ปุ่ม, ปุ่มเปลี่ยนภาษา 1 ปุ่ม)
   * 2. Empty Field Validation: ตรวจสอบระบบป้องกันการกรอกข้อมูลว่าง (ถ้ากดล็อกอินโดยไม่พิมพ์อะไร ต้องแสดง SnackBar และห้ามเรียก Cubit.login)
   * 3. Valid Submission: ตรวจสอบการส่งข้อมูล (เมื่อพิมพ์ข้อมูลครบและกดล็อกอิน ต้องเรียกฟังก์ชัน Cubit.login พร้อมส่งค่า Email และ Password ที่ถูกต้อง)
   * 4. Language Toggle: ตรวจสอบปุ่มเปลี่ยนภาษา (เมื่อกดปุ่ม ต้องเรียกคำสั่งสลับภาษาไปที่ Cubit.setLanguage)
   * 5. Loading State: ตรวจสอบการแสดงผลสถานะโหลด (หาก Cubit ปล่อย state loading ออกมา หน้าจอต้องแสดง LoadingIndicator)
   */
  group('LoginScreenView Widget Tests', () {
    testWidgets('renders all essential UI components', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.byType(FilledButton), findsOneWidget);

      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('shows SnackBar when fields are empty and login is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);

      verifyNever(() => mockLoginCubit.login(any(), any()));
    });

    testWidgets(
      'calls login on cubit when fields are valid and button is pressed',
      (tester) async {
        await tester.pumpWidget(makeTestableWidget(const LoginScreenView()));

        final textFields = find.byType(TextField);
        final emailField = textFields.first;
        final passwordField = textFields.last;

        await tester.enterText(emailField, 'test@jenosize.com');
        await tester.enterText(passwordField, 'password123');

        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();

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
