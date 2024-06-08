// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnvironmentModelImpl _$$EnvironmentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EnvironmentModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: (json['icon'] as num).toInt(),
      color: json['color'] as String,
      admins:
          (json['admins'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$EnvironmentModelImplToJson(
        _$EnvironmentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'color': instance.color,
      'admins': instance.admins,
    };
