// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointHistory _$PointHistoryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PointHistory', json, ($checkedConvert) {
      final val = PointHistory(
        id: $checkedConvert('id', (v) => v as String?),
        userId: $checkedConvert('userId', (v) => v as String?),
        title: $checkedConvert('title', (v) => v as String?),
        points: $checkedConvert('points', (v) => (v as num?)?.toInt()),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PointHistoryToJson(PointHistory instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'userId': ?instance.userId,
      'title': ?instance.title,
      'points': ?instance.points,
      'createdAt': ?instance.createdAt?.toIso8601String(),
    };
