import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_transaction.g.dart';

@JsonSerializable()
class PointTransaction extends Equatable {
  final String id;
  final String title;
  final int points;
  final DateTime date;

  const PointTransaction({
    required this.id,
    required this.title,
    required this.points,
    required this.date,
  });

  @override
  List<Object?> get props => [id, title, points, date];

  factory PointTransaction.fromJson(Map<String, dynamic> json) =>
      _$PointTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$PointTransactionToJson(this);
}
