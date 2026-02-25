import 'package:json_annotation/json_annotation.dart';

enum UserGender {
  @JsonValue('Male')
  male,
  @JsonValue('Female')
  female,
}
