import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'environment.freezed.dart';
part 'environment.g.dart';

@freezed
class EnvironmentModel with _$EnvironmentModel {
  const factory EnvironmentModel({
    required String id,
    required String name,
    required int icon,
    required String color,
    required List<String> admins,
  }) = _EnvironmentModel;

  factory EnvironmentModel.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentModelFromJson(json);
}
