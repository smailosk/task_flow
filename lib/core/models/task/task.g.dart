// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskModelImpl _$$TaskModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskModelImpl(
      title: json['title'] as String,
      id: json['id'] as String,
      done: json['done'] as bool,
      details: json['details'] as String,
      parentProjectId: json['parentProjectId'] as String,
      deadline: Converters.intToDateTime(json['deadline'] as int?),
      assignee: json['assignee'] as String,
    );

Map<String, dynamic> _$$TaskModelImplToJson(_$TaskModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'done': instance.done,
      'details': instance.details,
      'parentProjectId': instance.parentProjectId,
      'deadline': Converters.dateTimeToInt(instance.deadline),
      'assignee': instance.assignee,
    };
