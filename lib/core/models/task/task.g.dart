// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ToDoTaskImpl _$$ToDoTaskImplFromJson(Map<String, dynamic> json) =>
    _$ToDoTaskImpl(
      title: json['title'] as String,
      id: json['id'] as String,
      done: json['done'] as bool,
      details: json['details'] as String,
      parentProjectId: json['parentProjectId'] as String,
      deadline: Converters.timestampToDateTime(json['deadline'] as Timestamp?),
      assignee: json['assignee'] as String,
    );

Map<String, dynamic> _$$ToDoTaskImplToJson(_$ToDoTaskImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'done': instance.done,
      'details': instance.details,
      'parentProjectId': instance.parentProjectId,
      'deadline': Converters.dateTimeToTimestamp(instance.deadline),
      'assignee': instance.assignee,
    };
