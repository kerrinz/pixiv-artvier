// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'following_state_changed_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FollowingStateChangedArguments {
  String get userId => throw _privateConstructorUsedError;
  UserFollowState get state => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FollowingStateChangedArgumentsCopyWith<FollowingStateChangedArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FollowingStateChangedArgumentsCopyWith<$Res> {
  factory $FollowingStateChangedArgumentsCopyWith(
          FollowingStateChangedArguments value,
          $Res Function(FollowingStateChangedArguments) then) =
      _$FollowingStateChangedArgumentsCopyWithImpl<$Res,
          FollowingStateChangedArguments>;
  @useResult
  $Res call({String userId, UserFollowState state});
}

/// @nodoc
class _$FollowingStateChangedArgumentsCopyWithImpl<$Res,
        $Val extends FollowingStateChangedArguments>
    implements $FollowingStateChangedArgumentsCopyWith<$Res> {
  _$FollowingStateChangedArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as UserFollowState,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FollowingStateChangedArgumentsImplCopyWith<$Res>
    implements $FollowingStateChangedArgumentsCopyWith<$Res> {
  factory _$$FollowingStateChangedArgumentsImplCopyWith(
          _$FollowingStateChangedArgumentsImpl value,
          $Res Function(_$FollowingStateChangedArgumentsImpl) then) =
      __$$FollowingStateChangedArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, UserFollowState state});
}

/// @nodoc
class __$$FollowingStateChangedArgumentsImplCopyWithImpl<$Res>
    extends _$FollowingStateChangedArgumentsCopyWithImpl<$Res,
        _$FollowingStateChangedArgumentsImpl>
    implements _$$FollowingStateChangedArgumentsImplCopyWith<$Res> {
  __$$FollowingStateChangedArgumentsImplCopyWithImpl(
      _$FollowingStateChangedArgumentsImpl _value,
      $Res Function(_$FollowingStateChangedArgumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? state = null,
  }) {
    return _then(_$FollowingStateChangedArgumentsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as UserFollowState,
    ));
  }
}

/// @nodoc

class _$FollowingStateChangedArgumentsImpl
    implements _FollowingStateChangedArguments {
  const _$FollowingStateChangedArgumentsImpl(
      {required this.userId, required this.state});

  @override
  final String userId;
  @override
  final UserFollowState state;

  @override
  String toString() {
    return 'FollowingStateChangedArguments(userId: $userId, state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FollowingStateChangedArgumentsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FollowingStateChangedArgumentsImplCopyWith<
          _$FollowingStateChangedArgumentsImpl>
      get copyWith => __$$FollowingStateChangedArgumentsImplCopyWithImpl<
          _$FollowingStateChangedArgumentsImpl>(this, _$identity);
}

abstract class _FollowingStateChangedArguments
    implements FollowingStateChangedArguments {
  const factory _FollowingStateChangedArguments(
          {required final String userId,
          required final UserFollowState state}) =
      _$FollowingStateChangedArgumentsImpl;

  @override
  String get userId;
  @override
  UserFollowState get state;
  @override
  @JsonKey(ignore: true)
  _$$FollowingStateChangedArgumentsImplCopyWith<
          _$FollowingStateChangedArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
