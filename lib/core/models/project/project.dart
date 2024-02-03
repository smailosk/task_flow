import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    required String id,
    required String name,
    required String parentEnvironmentId,
    required List<String> members,
    required String color,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}
