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
    if (state.user == null) return;

    final histories = [history, ...state.pointHistories];
    _savePointHistories(histories);
    emit(state.copyWith(pointHistories: histories));
  }

  void clearData() {
    appStorage.remove(StorageKey.user.name);
    appStorage.remove(StorageKey.pointHistory.name);
    emit(state.clearData());
  }

  Future<void> _initialize() async {
    final user = await _loadUser();

    if (user == null) {
      clearData();
      return;
    }
    await _loadJoinedCampaigns();
    await _loadPointHistories();
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
    if (jsonMap != null && jsonMap['data'] is List) {
      final histories = (jsonMap['data'] as List)
          .map((e) => PointHistory.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(state.copyWith(pointHistories: histories));
    }
  }

  Future<void> _loadJoinedCampaigns() async {
    final Map<String, dynamic>? json = await appStorage.getJson(
      StorageKey.joinedCampaignIds.name,
    );
    final List<dynamic>? list = json?['ids'];
    if (list != null) {
      emit(state.copyWith(joinedCampaignIds: list.cast<String>().toSet()));
    }
  }

  void addJoinedCampaign(String id) async {
    final updatedIds = Set<String>.from(state.joinedCampaignIds)..add(id);
    await appStorage.setJson(StorageKey.joinedCampaignIds.name, {
      'ids': updatedIds.toList(),
    });
    emit(state.copyWith(joinedCampaignIds: updatedIds));
  }

  void _saveUser(User user) {
    appStorage.setJson(StorageKey.user.name, user.toJson());
  }

  void _savePointHistories(List<PointHistory?> histories) async {
    await appStorage.setJson(StorageKey.pointHistory.name, {
      'data': histories.map((e) => e?.toJson()).toList(),
    });
  }
}
