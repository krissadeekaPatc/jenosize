// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth _$AuthFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Auth', json, ($checkedConvert) {
      final val = Auth(
        accessToken: $checkedConvert('accessToken', (v) => v as String?),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String?),
        expiredAt: $checkedConvert(
          'expiredAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AuthToJson(Auth instance) => <String, dynamic>{
  'accessToken': ?instance.accessToken,
  'refreshToken': ?instance.refreshToken,
  'expiredAt': ?instance.expiredAt?.toIso8601String(),
};
