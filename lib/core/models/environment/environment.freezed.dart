// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'environment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EnvironmentModel _$EnvironmentModelFromJson(Map<String, dynamic> json) {
  return _EnvironmentModel.fromJson(json);
}

/// @nodoc
mixin _$EnvironmentModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get icon => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  List<String> get admins => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnvironmentModelCopyWith<EnvironmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnvironmentModelCopyWith<$Res> {
  factory $EnvironmentModelCopyWith(
          EnvironmentModel value, $Res Function(EnvironmentModel) then) =
      _$EnvironmentModelCopyWithImpl<$Res, EnvironmentModel>;
  @useResult
  $Res call(
      {String id, String name, int icon, String color, List<String> admins});
}

/// @nodoc
class _$EnvironmentModelCopyWithImpl<$Res, $Val extends EnvironmentModel>
    implements $EnvironmentModelCopyWith<$Res> {
  _$EnvironmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? color = null,
    Object? admins = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      admins: null == admins
          ? _value.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnvironmentModelImplCopyWith<$Res>
    implements $EnvironmentModelCopyWith<$Res> {
  factory _$$EnvironmentModelImplCopyWith(_$EnvironmentModelImpl value,
          $Res Function(_$EnvironmentModelImpl) then) =
      __$$EnvironmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String name, int icon, String color, List<String> admins});
}

/// @nodoc
class __$$EnvironmentModelImplCopyWithImpl<$Res>
    extends _$EnvironmentModelCopyWithImpl<$Res, _$EnvironmentModelImpl>
    implements _$$EnvironmentModelImplCopyWith<$Res> {
  __$$EnvironmentModelImplCopyWithImpl(_$EnvironmentModelImpl _value,
      $Res Function(_$EnvironmentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? icon = null,
    Object? color = null,
    Object? admins = null,
  }) {
    return _then(_$EnvironmentModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      admins: null == admins
          ? _value._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnvironmentModelImpl
    with DiagnosticableTreeMixin
    implements _EnvironmentModel {
  const _$EnvironmentModelImpl(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color,
      required final List<String> admins})
      : _admins = admins;

  factory _$EnvironmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnvironmentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int icon;
  @override
  final String color;
  final List<String> _admins;
  @override
  List<String> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EnvironmentModel(id: $id, name: $name, icon: $icon, color: $color, admins: $admins)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EnvironmentModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('icon', icon))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('admins', admins));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnvironmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other._admins, _admins));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, icon, color,
      const DeepCollectionEquality().hash(_admins));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnvironmentModelImplCopyWith<_$EnvironmentModelImpl> get copyWith =>
      __$$EnvironmentModelImplCopyWithImpl<_$EnvironmentModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnvironmentModelImplToJson(
      this,
    );
  }
}

abstract class _EnvironmentModel implements EnvironmentModel {
  const factory _EnvironmentModel(
      {required final String id,
      required final String name,
      required final int icon,
      required final String color,
      required final List<String> admins}) = _$EnvironmentModelImpl;

  factory _EnvironmentModel.fromJson(Map<String, dynamic> json) =
      _$EnvironmentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get icon;
  @override
  String get color;
  @override
  List<String> get admins;
  @override
  @JsonKey(ignore: true)
  _$$EnvironmentModelImplCopyWith<_$EnvironmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
