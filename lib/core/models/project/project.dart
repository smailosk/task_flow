import 'package:freezed_annotation/freezed_annotation.dart';
part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String name,
    required String parentEnvironmentId,
    required List<String> members,
    required String color,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}
