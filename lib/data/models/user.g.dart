// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate('User', json, (
  $checkedConvert,
) {
  final val = User(
    id: $checkedConvert('id', (v) => v as String?),
    firstName: $checkedConvert('firstName', (v) => v as String?),
    lastName: $checkedConvert('lastName', (v) => v as String?),
    email: $checkedConvert('email', (v) => v as String?),
    gender: $checkedConvert(
      'gender',
      (v) => $enumDecodeNullable(
        _$UserGenderEnumMap,
        v,
        unknownValue: JsonKey.nullForUndefinedEnumValue,
      ),
    ),
    totalPoints: $checkedConvert('totalPoints', (v) => (v as num?)?.toInt()),
    isMember: $checkedConvert('isMember', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': ?instance.id,
  'firstName': ?instance.firstName,
  'lastName': ?instance.lastName,
  'email': ?instance.email,
  'gender': ?_$UserGenderEnumMap[instance.gender],
  'totalPoints': ?instance.totalPoints,
  'isMember': ?instance.isMember,
};

const _$UserGenderEnumMap = {
  UserGender.male: 'Male',
  UserGender.female: 'Female',
};
