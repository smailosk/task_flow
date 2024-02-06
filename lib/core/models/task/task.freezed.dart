// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  String get title => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;
  String get details => throw _privateConstructorUsedError;
  String get parentProjectId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Converters.intToDateTime, toJson: Converters.dateTimeToInt)
  DateTime? get deadline => throw _privateConstructorUsedError;
  String get assignee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {String title,
      String id,
      bool done,
      String details,
      String parentProjectId,
      @JsonKey(
          fromJson: Converters.intToDateTime, toJson: Converters.dateTimeToInt)
      DateTime? deadline,
      String assignee});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = null,
    Object? done = null,
    Object? details = null,
    Object? parentProjectId = null,
    Object? deadline = freezed,
    Object? assignee = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
      parentProjectId: null == parentProjectId
          ? _value.parentProjectId
          : parentProjectId // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      assignee: null == assignee
          ? _value.assignee
          : assignee // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskModelImplCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$$TaskModelImplCopyWith(
          _$TaskModelImpl value, $Res Function(_$TaskModelImpl) then) =
      __$$TaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String id,
      bool done,
      String details,
      String parentProjectId,
      @JsonKey(
          fromJson: Converters.intToDateTime, toJson: Converters.dateTimeToInt)
      DateTime? deadline,
      String assignee});
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
      _$TaskModelImpl _value, $Res Function(_$TaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = null,
    Object? done = null,
    Object? details = null,
    Object? parentProjectId = null,
    Object? deadline = freezed,
    Object? assignee = null,
  }) {
    return _then(_$TaskModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String,
      parentProjectId: null == parentProjectId
          ? _value.parentProjectId
          : parentProjectId // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      assignee: null == assignee
          ? _value.assignee
          : assignee // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskModelImpl implements _TaskModel {
  const _$TaskModelImpl(
      {required this.title,
      required this.id,
      required this.done,
      required this.details,
      required this.parentProjectId,
      @JsonKey(
          fromJson: Converters.intToDateTime, toJson: Converters.dateTimeToInt)
      required this.deadline,
      required this.assignee});

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  final String title;
  @override
  final String id;
  @override
  final bool done;
  @override
  final String details;
  @override
  final String parentProjectId;
  @override
  @JsonKey(fromJson: Converters.intToDateTime, toJson: Converters.dateTimeToInt)
  final DateTime? deadline;
  @override
  final String assignee;

  @override
  String toString() {
    return 'TaskModel(title: $title, id: $id, done: $done, details: $details, parentProjectId: $parentProjectId, deadline: $deadline, assignee: $assignee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.parentProjectId, parentProjectId) ||
                other.parentProjectId == parentProjectId) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.assignee, assignee) ||
                other.assignee == assignee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, id, done, details,
      parentProjectId, deadline, assignee);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      __$$TaskModelImplCopyWithImpl<_$TaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskModelImplToJson(
      this,
    );
  }
}

abstract class _TaskModel implements TaskModel {
  const factory _TaskModel(
      {required final String title,
      required final String id,
      required final bool done,
      required final String details,
      required final String parentProjectId,
      @JsonKey(
          fromJson: Converters.intToDateTime, toJson: Converters.dateTimeToInt)
      required final DateTime? deadline,
      required final String assignee}) = _$TaskModelImpl;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  String get title;
  @override
  String get id;
  @override
  bool get done;
  @override
  String get details;
  @override
  String get parentProjectId;
  @override
  @JsonKey(fromJson: Converters.intToDateTime, toJson: Converters.dateTimeToInt)
  DateTime? get deadline;
  @override
  String get assignee;
  @override
  @JsonKey(ignore: true)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
