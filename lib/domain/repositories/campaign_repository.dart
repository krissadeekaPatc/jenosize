import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/domain/core/result.dart';

abstract class CampaignRepository {
  Future<Result<List<Campaign>>> getCampaigns();
  Future<Result<void>> joinCampaign(String campaignId);
}
