import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/storages/app_storage.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AppStorage appStorage;
  SessionCubit({required this.appStorage}) : super(const SessionState()) {
    _loadUserFromStorage();
  }

  void setUser(User? newValue) {
    if (newValue != null) {
      appStorage.setString(StorageKey.user.name, jsonEncode(newValue));
    } else {
      appStorage.remove(StorageKey.user.name);
    }
    emit(state.copyWith(user: newValue));
  }

  void _loadUserFromStorage() async {
    final String? rawUser = await appStorage.getString(StorageKey.user.name);
    if (rawUser != null) {
      final user = User.fromJson(jsonDecode(rawUser));
      emit(state.copyWith(user: user));
    }
  }

  void clearData() {
    appStorage.remove(StorageKey.user.name);
    emit(state.clearData());
  }
}
