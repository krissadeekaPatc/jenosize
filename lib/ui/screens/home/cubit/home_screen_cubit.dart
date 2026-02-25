import 'package:jenosize/domain/core/result.dart';
import 'package:jenosize/domain/repositories/campaign_repository.dart';
import 'package:jenosize/ui/screens/home/cubit/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final CampaignRepository campaignRepository;

  HomeScreenCubit({
    required this.campaignRepository,
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
}
