import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_history.g.dart';

@JsonSerializable()
class PointHistory extends Equatable {
  final String? id;
  final String? userId;
  final String? title;
  final int? points;
  final DateTime? createdAt;

  const PointHistory({
    this.id,
    this.userId,
    this.title,
    this.points,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    title,
    points,
    createdAt,
  ];

  factory PointHistory.fromJson(Map<String, dynamic> json) =>
      _$PointHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$PointHistoryToJson(this);
}
