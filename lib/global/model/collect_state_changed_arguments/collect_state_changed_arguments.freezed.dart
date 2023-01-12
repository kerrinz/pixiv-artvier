// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collect_state_changed_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CollectStateChangedArguments {
  String get worksId => throw _privateConstructorUsedError;
  CollectState get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectStateChangedArgumentsCopyWith<CollectStateChangedArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectStateChangedArgumentsCopyWith<$Res> {
  factory $CollectStateChangedArgumentsCopyWith(
          CollectStateChangedArguments value,
          $Res Function(CollectStateChangedArguments) then) =
      _$CollectStateChangedArgumentsCopyWithImpl<$Res,
          CollectStateChangedArguments>;
  @useResult
  $Res call({String worksId, CollectState state});
}

/// @nodoc
class _$CollectStateChangedArgumentsCopyWithImpl<$Res,
        $Val extends CollectStateChangedArguments>
    implements $CollectStateChangedArgumentsCopyWith<$Res> {
  _$CollectStateChangedArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worksId = null,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as CollectState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CollectStateChangedArgumentsCopyWith<$Res>
    implements $CollectStateChangedArgumentsCopyWith<$Res> {
  factory _$$_CollectStateChangedArgumentsCopyWith(
          _$_CollectStateChangedArguments value,
          $Res Function(_$_CollectStateChangedArguments) then) =
      __$$_CollectStateChangedArgumentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String worksId, CollectState state});
}

/// @nodoc
class __$$_CollectStateChangedArgumentsCopyWithImpl<$Res>
    extends _$CollectStateChangedArgumentsCopyWithImpl<$Res,
        _$_CollectStateChangedArguments>
    implements _$$_CollectStateChangedArgumentsCopyWith<$Res> {
  __$$_CollectStateChangedArgumentsCopyWithImpl(
      _$_CollectStateChangedArguments _value,
      $Res Function(_$_CollectStateChangedArguments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worksId = null,
    Object? state = null,
  }) {
    return _then(_$_CollectStateChangedArguments(
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as CollectState,
    ));
  }
}

/// @nodoc

class _$_CollectStateChangedArguments implements _CollectStateChangedArguments {
  const _$_CollectStateChangedArguments(
      {required this.worksId, required this.state});

  @override
  final String worksId;
  @override
  final CollectState state;

  @override
  String toString() {
    return 'CollectStateChangedArguments(worksId: $worksId, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CollectStateChangedArguments &&
            (identical(other.worksId, worksId) || other.worksId == worksId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, worksId, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CollectStateChangedArgumentsCopyWith<_$_CollectStateChangedArguments>
      get copyWith => __$$_CollectStateChangedArgumentsCopyWithImpl<
          _$_CollectStateChangedArguments>(this, _$identity);
}

abstract class _CollectStateChangedArguments
    implements CollectStateChangedArguments {
  const factory _CollectStateChangedArguments(
      {required final String worksId,
      required final CollectState state}) = _$_CollectStateChangedArguments;

  @override
  String get worksId;
  @override
  CollectState get state;
  @override
  @JsonKey(ignore: true)
  _$$_CollectStateChangedArgumentsCopyWith<_$_CollectStateChangedArguments>
      get copyWith => throw _privateConstructorUsedError;
}
