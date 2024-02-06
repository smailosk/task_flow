// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
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
        fromJson: Converters.timestampToDateTime,
        toJson: Converters.dateTimeToTimestamp)
    required DateTime? deadline,
    required String assignee,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);
}
