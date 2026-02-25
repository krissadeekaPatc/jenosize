// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campaign _$CampaignFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Campaign', json, ($checkedConvert) {
      final val = Campaign(
        id: $checkedConvert('id', (v) => v as String?),
        title: $checkedConvert('title', (v) => v as String?),
        description: $checkedConvert('description', (v) => v as String?),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String?),
        pointsReward: $checkedConvert(
          'pointsReward',
          (v) => (v as num?)?.toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CampaignToJson(Campaign instance) => <String, dynamic>{
  'id': ?instance.id,
  'title': ?instance.title,
  'description': ?instance.description,
  'imageUrl': ?instance.imageUrl,
  'pointsReward': ?instance.pointsReward,
};
