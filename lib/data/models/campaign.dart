import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'campaign.g.dart';

@JsonSerializable()
class Campaign extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final int? pointsReward;

  const Campaign({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.pointsReward,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, pointsReward];

  factory Campaign.fromJson(Map<String, dynamic> json) =>
      _$CampaignFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignToJson(this);
}
