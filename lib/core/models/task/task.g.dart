// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      title: json['title'] as String,
      id: json['id'] as String,
      done: json['done'] as bool,
      details: json['details'] as String,
      parentProjectId: json['parentProjectId'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      assignee: json['assignee'] as String,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'done': instance.done,
      'details': instance.details,
      'parentProjectId': instance.parentProjectId,
      'deadline': instance.deadline.toIso8601String(),
      'assignee': instance.assignee,
    };
