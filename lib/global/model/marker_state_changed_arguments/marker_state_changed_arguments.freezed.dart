// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'marker_state_changed_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MarkerStateChangedArguments {
  String get worksId => throw _privateConstructorUsedError;

  /// 书签页
  int? get page => throw _privateConstructorUsedError;
  MarkerState get state => throw _privateConstructorUsedError;

  /// Create a copy of MarkerStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkerStateChangedArgumentsCopyWith<MarkerStateChangedArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkerStateChangedArgumentsCopyWith<$Res> {
  factory $MarkerStateChangedArgumentsCopyWith(
          MarkerStateChangedArguments value,
          $Res Function(MarkerStateChangedArguments) then) =
      _$MarkerStateChangedArgumentsCopyWithImpl<$Res,
          MarkerStateChangedArguments>;
  @useResult
  $Res call({String worksId, int? page, MarkerState state});
}

/// @nodoc
class _$MarkerStateChangedArgumentsCopyWithImpl<$Res,
        $Val extends MarkerStateChangedArguments>
    implements $MarkerStateChangedArgumentsCopyWith<$Res> {
  _$MarkerStateChangedArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkerStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worksId = null,
    Object? page = freezed,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as MarkerState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MarkerStateChangedArgumentsImplCopyWith<$Res>
    implements $MarkerStateChangedArgumentsCopyWith<$Res> {
  factory _$$MarkerStateChangedArgumentsImplCopyWith(
          _$MarkerStateChangedArgumentsImpl value,
          $Res Function(_$MarkerStateChangedArgumentsImpl) then) =
      __$$MarkerStateChangedArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String worksId, int? page, MarkerState state});
}

/// @nodoc
class __$$MarkerStateChangedArgumentsImplCopyWithImpl<$Res>
    extends _$MarkerStateChangedArgumentsCopyWithImpl<$Res,
        _$MarkerStateChangedArgumentsImpl>
    implements _$$MarkerStateChangedArgumentsImplCopyWith<$Res> {
  __$$MarkerStateChangedArgumentsImplCopyWithImpl(
      _$MarkerStateChangedArgumentsImpl _value,
      $Res Function(_$MarkerStateChangedArgumentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MarkerStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worksId = null,
    Object? page = freezed,
    Object? state = null,
  }) {
    return _then(_$MarkerStateChangedArgumentsImpl(
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      page: freezed == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as MarkerState,
    ));
  }
}

/// @nodoc

class _$MarkerStateChangedArgumentsImpl
    implements _MarkerStateChangedArguments {
  const _$MarkerStateChangedArgumentsImpl(
      {required this.worksId, required this.page, required this.state});

  @override
  final String worksId;

  /// 书签页
  @override
  final int? page;
  @override
  final MarkerState state;

  @override
  String toString() {
    return 'MarkerStateChangedArguments(worksId: $worksId, page: $page, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkerStateChangedArgumentsImpl &&
            (identical(other.worksId, worksId) || other.worksId == worksId) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, worksId, page, state);

  /// Create a copy of MarkerStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkerStateChangedArgumentsImplCopyWith<_$MarkerStateChangedArgumentsImpl>
      get copyWith => __$$MarkerStateChangedArgumentsImplCopyWithImpl<
          _$MarkerStateChangedArgumentsImpl>(this, _$identity);
}

abstract class _MarkerStateChangedArguments
    implements MarkerStateChangedArguments {
  const factory _MarkerStateChangedArguments(
      {required final String worksId,
      required final int? page,
      required final MarkerState state}) = _$MarkerStateChangedArgumentsImpl;

  @override
  String get worksId;

  /// 书签页
  @override
  int? get page;
  @override
  MarkerState get state;

  /// Create a copy of MarkerStateChangedArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkerStateChangedArgumentsImplCopyWith<_$MarkerStateChangedArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
