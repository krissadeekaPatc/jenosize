import 'package:app_template/data/models/campaign.dart';
import 'package:app_template/domain/core/result.dart';

abstract class CampaignRepository {
  Future<Result<List<Campaign>>> getCampaigns();
  Future<Result<void>> joinCampaign(String campaignId);
}
