import 'package:equatable/equatable.dart';
import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/data/models/user.dart';

class SessionState extends Equatable {
  final User? user;
  final List<PointHistory?> pointHistories;
  final Set<String> joinedCampaignIds;

  const SessionState({
    this.user,
    this.pointHistories = const [],
    this.joinedCampaignIds = const {},
  });

  @override
  List<Object?> get props => [
    user,
    pointHistories,
    joinedCampaignIds,
  ];

  SessionState copyWith({
    User? user,
    List<PointHistory?>? pointHistories,
    Set<String>? joinedCampaignIds,
  }) {
    return SessionState(
      user: user ?? this.user,
      pointHistories: pointHistories ?? this.pointHistories,
      joinedCampaignIds: joinedCampaignIds ?? this.joinedCampaignIds,
    );
  }

  SessionState clearData() {
    return const SessionState();
  }

  bool isAuthenticated() {
    return user != null;
  }
}
