// import 'package:jenosize/data/models/requests/login_with_email_request.dart';
// import 'package:jenosize/domain/core/app_error.dart';
// import 'package:jenosize/domain/core/result.dart';
// import 'package:jenosize/ui/screens/login/cubit/login_screen_cubit.dart';
// import 'package:jenosize/ui/screens/login/cubit/login_screen_state.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../mocks.dart';

// void main() {
//   late MockLoginWithEmailUseCase mockLoginWithEmailUseCase;
//   late LoginScreenCubit cubit;

//   setUpAll(() {
//     registerFallbackValue(
//       const LoginWithEmailRequest(email: '', password: ''),
//     );
//   });

//   setUp(() {
//     mockLoginWithEmailUseCase = MockLoginWithEmailUseCase();
//     cubit = LoginScreenCubit(loginWithEmailUseCase: mockLoginWithEmailUseCase);
//   });

//   tearDown(() async {
//     await cubit.close();
//   });

//   group('LoginScreenCubit', () {
//     test('initial state is LoginScreenState.initial', () {
//       expect(cubit.state, equals(const LoginScreenState()));
//     });

//     blocTest<LoginScreenCubit, LoginScreenState>(
//       'emits [loading, success] when login is successful',
//       build: () {
//         when(
//           () => mockLoginWithEmailUseCase.call(request: any(named: 'request')),
//         ).thenAnswer((_) async => Success(Unit()));

//         return cubit;
//       },
//       act: (cubit) => cubit.login(),
//       verify: (_) {
//         verify(
//           () => mockLoginWithEmailUseCase.call(request: any(named: 'request')),
//         ).called(1);
//       },
//       expect: () => [
//         const LoginScreenState(
//           status: LoginScreenStatus.loading,
//           error: null,
//         ),
//         const LoginScreenState(
//           status: LoginScreenStatus.success,
//           error: null,
//         ),
//       ],
//     );

//     final loginError = const AppError(message: 'Login failed');
//     blocTest<LoginScreenCubit, LoginScreenState>(
//       'emits [loading, failure] when login fails',
//       build: () {
//         when(
//           () => mockLoginWithEmailUseCase.call(request: any(named: 'request')),
//         ).thenAnswer((_) async => Failure(loginError));
//         return cubit;
//       },
//       act: (cubit) => cubit.login(),
//       verify: (_) {
//         verify(
//           () => mockLoginWithEmailUseCase.call(request: any(named: 'request')),
//         ).called(1);
//       },
//       expect: () => [
//         const LoginScreenState(
//           status: LoginScreenStatus.loading,
//           error: null,
//         ),
//         LoginScreenState(
//           status: LoginScreenStatus.failure,
//           error: loginError,
//         ),
//       ],
//     );
//   });
// }
