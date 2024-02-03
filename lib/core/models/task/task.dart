import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String title,
    required String id,
    required bool done,
    required String details,
    required String parentProjectId,
    required DateTime deadline,
    required String assignee,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
