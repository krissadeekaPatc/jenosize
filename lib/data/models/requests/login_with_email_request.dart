import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_with_email_request.g.dart';

@JsonSerializable()
class LoginWithEmailRequest extends Equatable {
  final String? email;
  final String? password;

  const LoginWithEmailRequest({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
    email,
    password,
  ];

  factory LoginWithEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginWithEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginWithEmailRequestToJson(this);
}
