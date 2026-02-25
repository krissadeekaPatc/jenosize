import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:jenosize/data/models/campaign.dart';
import 'package:jenosize/generated/assets.gen.dart';

class CampaignRemoteDataSource {
  final AssetBundle bundle;

  CampaignRemoteDataSource({required this.bundle});

  Future<List<Campaign>> getCampaigns() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    final String response = await bundle.loadString(Assets.mocks.campaign);

    final List<dynamic> data = json.decode(response);

    return data.map((json) => Campaign.fromJson(json)).toList();
  }

  Future<void> joinCampaign(String campaignId) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
