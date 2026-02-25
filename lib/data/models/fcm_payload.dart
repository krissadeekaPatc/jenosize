import 'package:app_template/common/logger.dart';
import 'package:app_template/data/enums/fcm_target_type.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fcm_payload.g.dart';

@JsonSerializable()
class FcmPayload extends Equatable {
  final String? title;
  final String? body;
  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final FcmTargetType? targetType;
  final String? targetId;

  const FcmPayload({
    this.title,
    this.body,
    this.targetType,
    this.targetId,
  });

  @override
  List<Object?> get props => [
    title,
    body,
    targetType,
    targetId,
  ];

  factory FcmPayload.fromJson(Map<String, dynamic> json) =>
      _$FcmPayloadFromJson(json);

  static FcmPayload? fromJsonOrNull(Map<String, dynamic>? json) {
    if (json == null) return null;
    try {
      final result = FcmPayload.fromJson(json);
      return result;
    } catch (error, stackTrace) {
      Logger.logError(
        'Error fromJsonOrNull',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  Map<String, dynamic> toJson() => _$FcmPayloadToJson(this);
}
