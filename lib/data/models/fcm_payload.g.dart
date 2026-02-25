// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FcmPayload _$FcmPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FcmPayload', json, ($checkedConvert) {
      final val = FcmPayload(
        title: $checkedConvert('title', (v) => v as String?),
        body: $checkedConvert('body', (v) => v as String?),
        targetType: $checkedConvert(
          'targetType',
          (v) => $enumDecodeNullable(
            _$FcmTargetTypeEnumMap,
            v,
            unknownValue: JsonKey.nullForUndefinedEnumValue,
          ),
        ),
        targetId: $checkedConvert('targetId', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$FcmPayloadToJson(FcmPayload instance) =>
    <String, dynamic>{
      'title': ?instance.title,
      'body': ?instance.body,
      'targetType': ?_$FcmTargetTypeEnumMap[instance.targetType],
      'targetId': ?instance.targetId,
    };

const _$FcmTargetTypeEnumMap = {FcmTargetType.unknown: 'unknown'};
