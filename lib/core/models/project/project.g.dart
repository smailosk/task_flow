// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModelImpl _$$ProjectModelImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      parentEnvironmentId: json['parentEnvironmentId'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$$ProjectModelImplToJson(_$ProjectModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentEnvironmentId': instance.parentEnvironmentId,
      'members': instance.members,
      'color': instance.color,
    };
