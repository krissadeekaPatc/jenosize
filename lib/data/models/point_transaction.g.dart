// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointTransaction _$PointTransactionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PointTransaction', json, ($checkedConvert) {
      final val = PointTransaction(
        id: $checkedConvert('id', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        points: $checkedConvert('points', (v) => (v as num).toInt()),
        date: $checkedConvert('date', (v) => DateTime.parse(v as String)),
      );
      return val;
    });

Map<String, dynamic> _$PointTransactionToJson(PointTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'points': instance.points,
      'date': instance.date.toIso8601String(),
    };
