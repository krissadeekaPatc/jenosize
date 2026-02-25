import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/data/models/point_history.dart';
import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/campaign_repository.dart';
import 'package:jenosize/ui/cubits/session/session_cubit.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final CampaignRepository campaignRepository;
  final SessionCubit sessionCubit;
  HomeScreenCubit({
    required this.campaignRepository,
    required this.sessionCubit,
  }) : super(const HomeScreenState());

  Future<void> loadCampaigns() async {
    emit(state.copyWith(status: HomeScreenStatus.loading));

    final result = await campaignRepository.getCampaigns();

    switch (result) {
      case Success(value: final campaigns):
        emit(
          state.ready(campaigns: campaigns),
        );
      case Failure(error: final error):
        emit(state.failure(error));
    }
  }

  Future<void> joinCampaign(Campaign? campaign) async {
    if (campaign == null) return;
    emit(state.copyWith(status: HomeScreenStatus.loading));

    final result = await campaignRepository.joinCampaign(campaign.id!);

    switch (result) {
      case Success():
        final pointHistory = PointHistory(
          id: campaign.id,
          points: campaign.pointsReward,
          title: campaign.title,
          userId: sessionCubit.state.user?.id,
          createdAt: DateTime.now(),
        );
        sessionCubit.addJoinedCampaign(campaign.id!);
        sessionCubit.addPointHistory(pointHistory);
        sessionCubit.setUser(
          sessionCubit.state.user?.copyWith(
            totalPoints:
                sessionCubit.state.user!.totalPoints! + campaign.pointsReward!,
          ),
        );
        emit(state.ready());
      case Failure(error: final error):
        emit(state.failure(error));
    }
  }
}
