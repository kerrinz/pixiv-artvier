// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'series_state_changed_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SeriesStateChangedArguments {
  String get seriesId => throw _privateConstructorUsedError;
  SeriesState get state => throw _privateConstructorUsedError;

  /// Create a copy of SeriesStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeriesStateChangedArgumentsCopyWith<SeriesStateChangedArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesStateChangedArgumentsCopyWith<$Res> {
  factory $SeriesStateChangedArgumentsCopyWith(
          SeriesStateChangedArguments value,
          $Res Function(SeriesStateChangedArguments) then) =
      _$SeriesStateChangedArgumentsCopyWithImpl<$Res,
          SeriesStateChangedArguments>;
  @useResult
  $Res call({String seriesId, SeriesState state});
}

/// @nodoc
class _$SeriesStateChangedArgumentsCopyWithImpl<$Res,
        $Val extends SeriesStateChangedArguments>
    implements $SeriesStateChangedArgumentsCopyWith<$Res> {
  _$SeriesStateChangedArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeriesStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seriesId = null,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      seriesId: null == seriesId
          ? _value.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SeriesState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SeriesStateChangedArgumentsImplCopyWith<$Res>
    implements $SeriesStateChangedArgumentsCopyWith<$Res> {
  factory _$$SeriesStateChangedArgumentsImplCopyWith(
          _$SeriesStateChangedArgumentsImpl value,
          $Res Function(_$SeriesStateChangedArgumentsImpl) then) =
      __$$SeriesStateChangedArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String seriesId, SeriesState state});
}

/// @nodoc
class __$$SeriesStateChangedArgumentsImplCopyWithImpl<$Res>
    extends _$SeriesStateChangedArgumentsCopyWithImpl<$Res,
        _$SeriesStateChangedArgumentsImpl>
    implements _$$SeriesStateChangedArgumentsImplCopyWith<$Res> {
  __$$SeriesStateChangedArgumentsImplCopyWithImpl(
      _$SeriesStateChangedArgumentsImpl _value,
      $Res Function(_$SeriesStateChangedArgumentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SeriesStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seriesId = null,
    Object? state = null,
  }) {
    return _then(_$SeriesStateChangedArgumentsImpl(
      seriesId: null == seriesId
          ? _value.seriesId
          : seriesId // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as SeriesState,
    ));
  }
}

/// @nodoc

class _$SeriesStateChangedArgumentsImpl
    implements _SeriesStateChangedArguments {
  const _$SeriesStateChangedArgumentsImpl(
      {required this.seriesId, required this.state});

  @override
  final String seriesId;
  @override
  final SeriesState state;

  @override
  String toString() {
    return 'SeriesStateChangedArguments(seriesId: $seriesId, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeriesStateChangedArgumentsImpl &&
            (identical(other.seriesId, seriesId) ||
                other.seriesId == seriesId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, seriesId, state);

  /// Create a copy of SeriesStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeriesStateChangedArgumentsImplCopyWith<_$SeriesStateChangedArgumentsImpl>
      get copyWith => __$$SeriesStateChangedArgumentsImplCopyWithImpl<
          _$SeriesStateChangedArgumentsImpl>(this, _$identity);
}

abstract class _SeriesStateChangedArguments
    implements SeriesStateChangedArguments {
  const factory _SeriesStateChangedArguments(
      {required final String seriesId,
      required final SeriesState state}) = _$SeriesStateChangedArgumentsImpl;

  @override
  String get seriesId;
  @override
  SeriesState get state;

  /// Create a copy of SeriesStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeriesStateChangedArgumentsImplCopyWith<_$SeriesStateChangedArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
