// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_with_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginWithEmailRequest _$LoginWithEmailRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('LoginWithEmailRequest', json, ($checkedConvert) {
  final val = LoginWithEmailRequest(
    email: $checkedConvert('email', (v) => v as String?),
    password: $checkedConvert('password', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$LoginWithEmailRequestToJson(
  LoginWithEmailRequest instance,
) => <String, dynamic>{
  'email': ?instance.email,
  'password': ?instance.password,
};
