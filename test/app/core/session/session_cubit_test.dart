import 'package:app_template/data/models/user.dart';
import 'package:app_template/ui/cubits/session/session_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SessionCubit cubit;

  setUp(() {
    cubit = SessionCubit();
  });

  tearDown(() async {
    await cubit.close();
  });

  test('setUser() updates user in state', () async {
    final user = const User(id: '1', firstName: 'User');
    cubit.setUser(user);
    expect(cubit.state.user, equals(user));
  });

  test('clearData() clears state and deletes from storage', () async {
    cubit.clearData();
    expect(cubit.state.user, isNull);
  });
}
