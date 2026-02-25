import 'package:app_template/data/models/user.dart';
import 'package:app_template/ui/cubits/session/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit() : super(const SessionState());

  void setUser(User? newValue) {
    emit(state.copyWith(user: newValue));
  }

  void clearData() {
    emit(state.clearData());
  }
}
