import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/campaign_repository.dart';
import 'package:app_template/ui/screens/home/cubit/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final CampaignRepository _campaignRepository;

  HomeScreenCubit(this._campaignRepository) : super(const HomeScreenState());

  Future<void> loadCampaigns() async {
    emit(state.copyWith(status: HomeScreenStatus.loading));

    final result = await _campaignRepository.getCampaigns();

    switch (result) {
      case Success(value: final campaigns):
        emit(
          state.copyWith(
            status: HomeScreenStatus.ready,
            campaigns: campaigns,
          ),
        );
      case Failure(error: final error):
        emit(state.failure(error));
    }
  }
}
