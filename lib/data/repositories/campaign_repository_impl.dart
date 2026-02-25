import 'package:app_template/data/data_sources/campaign_remote_data_source.dart';
import 'package:app_template/data/models/campaign.dart';
import 'package:app_template/domain/core/app_error.dart';
import 'package:app_template/domain/core/result.dart';
import 'package:app_template/domain/repositories/campaign_repository.dart';

class CampaignRepositoryImpl implements CampaignRepository {
  final CampaignRemoteDataSource _dataSource;

  const CampaignRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<Campaign>>> getCampaigns() async {
    try {
      final campaigns = await _dataSource.getCampaigns();
      return Success(campaigns);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }

  @override
  Future<Result<void>> joinCampaign(String campaignId) async {
    try {
      await _dataSource.joinCampaign(campaignId);
      return const Success(null);
    } catch (e) {
      return Failure(AppError.from(e));
    }
  }
}
