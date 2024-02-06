// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_flow/core/utils/converters.dart';
part 'task.freezed.dart';
part 'task.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String title,
    required String id,
    required bool done,
    required String details,
    required String parentProjectId,
    @JsonKey(
        fromJson: Converters.intToDateTime, toJson: Converters.dateTimeToInt)
    required DateTime? deadline,
    required String assignee,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
