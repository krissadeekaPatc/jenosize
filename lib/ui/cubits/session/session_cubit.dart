import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/data/models/user.dart';
import 'package:jenosize/domain/storages/app_storage.dart';
import 'package:jenosize/ui/cubits/session/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AppStorage appStorage;

  SessionCubit({required this.appStorage}) : super(const SessionState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    final user = await _loadUser();

    if (user == null) {
      clearData();
      return;
    }

    await Future.wait([
      _loadJoinedCampaigns(),
      _loadPointHistories(),
    ]);
  }

  void setUser(User? newValue) {
    if (newValue == null) {
      clearData();
      return;
    }
    _saveUser(newValue);
    emit(state.copyWith(user: newValue));
  }

  void setPointHistories(List<PointHistory?> histories) {
    if (state.user == null) return;

    _savePointHistories(histories);
    emit(state.copyWith(pointHistories: histories));
  }

  void addPointHistory(PointHistory? history) {
    if (state.user == null || history == null) return;

    setPointHistories([history, ...state.pointHistories]);
  }

  void addJoinedCampaign(String id) {
    final updatedIds = Set<String>.from(state.joinedCampaignIds)..add(id);

    emit(state.copyWith(joinedCampaignIds: updatedIds));

    appStorage.setJson(StorageKey.joinedCampaignIds.name, {
      'ids': updatedIds.toList(),
    });
  }

  void clearData() {
    appStorage.remove(StorageKey.user.name);
    appStorage.remove(StorageKey.pointHistory.name);
    appStorage.remove(StorageKey.joinedCampaignIds.name);
    emit(state.clearData());
  }

  Future<User?> _loadUser() async {
    final user = await appStorage.getObject<User>(
      StorageKey.user.name,
      fromJson: User.fromJson,
    );
    if (user != null) {
      emit(state.copyWith(user: user));
    }
    return user;
  }

  Future<void> _loadPointHistories() async {
    final jsonMap = await appStorage.getJson(StorageKey.pointHistory.name);
    final list = jsonMap?['data'] as List?;

    if (list != null) {
      final histories = list
          .map((e) => PointHistory.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(state.copyWith(pointHistories: histories));
    }
  }

  Future<void> _loadJoinedCampaigns() async {
    final jsonMap = await appStorage.getJson(StorageKey.joinedCampaignIds.name);
    final list = jsonMap?['ids'] as List?;

    if (list != null) {
      emit(state.copyWith(joinedCampaignIds: list.cast<String>().toSet()));
    }
  }

  void _saveUser(User user) {
    appStorage.setJson(StorageKey.user.name, user.toJson());
  }

  void _savePointHistories(List<PointHistory?> histories) {
    appStorage.setJson(StorageKey.pointHistory.name, {
      'data': histories.map((e) => e?.toJson()).toList(),
    });
  }
}
