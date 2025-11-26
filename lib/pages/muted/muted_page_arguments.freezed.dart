// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'muted_page_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MutedPageArguments {
  List<CommonUser> get users => throw _privateConstructorUsedError;
  List<CommonTag> get tags => throw _privateConstructorUsedError;

  /// Create a copy of MutedPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MutedPageArgumentsCopyWith<MutedPageArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MutedPageArgumentsCopyWith<$Res> {
  factory $MutedPageArgumentsCopyWith(
          MutedPageArguments value, $Res Function(MutedPageArguments) then) =
      _$MutedPageArgumentsCopyWithImpl<$Res, MutedPageArguments>;
  @useResult
  $Res call({List<CommonUser> users, List<CommonTag> tags});
}

/// @nodoc
class _$MutedPageArgumentsCopyWithImpl<$Res, $Val extends MutedPageArguments>
    implements $MutedPageArgumentsCopyWith<$Res> {
  _$MutedPageArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MutedPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<CommonUser>,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<CommonTag>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MutedPageArgumentsImplCopyWith<$Res>
    implements $MutedPageArgumentsCopyWith<$Res> {
  factory _$$MutedPageArgumentsImplCopyWith(_$MutedPageArgumentsImpl value,
          $Res Function(_$MutedPageArgumentsImpl) then) =
      __$$MutedPageArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CommonUser> users, List<CommonTag> tags});
}

/// @nodoc
class __$$MutedPageArgumentsImplCopyWithImpl<$Res>
    extends _$MutedPageArgumentsCopyWithImpl<$Res, _$MutedPageArgumentsImpl>
    implements _$$MutedPageArgumentsImplCopyWith<$Res> {
  __$$MutedPageArgumentsImplCopyWithImpl(_$MutedPageArgumentsImpl _value,
      $Res Function(_$MutedPageArgumentsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MutedPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? tags = null,
  }) {
    return _then(_$MutedPageArgumentsImpl(
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<CommonUser>,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<CommonTag>,
    ));
  }
}

/// @nodoc

class _$MutedPageArgumentsImpl implements _MutedPageArguments {
  const _$MutedPageArgumentsImpl(
      {required final List<CommonUser> users,
      required final List<CommonTag> tags})
      : _users = users,
        _tags = tags;

  final List<CommonUser> _users;
  @override
  List<CommonUser> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  final List<CommonTag> _tags;
  @override
  List<CommonTag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'MutedPageArguments(users: $users, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MutedPageArgumentsImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_users),
      const DeepCollectionEquality().hash(_tags));

  /// Create a copy of MutedPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MutedPageArgumentsImplCopyWith<_$MutedPageArgumentsImpl> get copyWith =>
      __$$MutedPageArgumentsImplCopyWithImpl<_$MutedPageArgumentsImpl>(
          this, _$identity);
}

abstract class _MutedPageArguments implements MutedPageArguments {
  const factory _MutedPageArguments(
      {required final List<CommonUser> users,
      required final List<CommonTag> tags}) = _$MutedPageArgumentsImpl;

  @override
  List<CommonUser> get users;
  @override
  List<CommonTag> get tags;

  /// Create a copy of MutedPageArguments
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MutedPageArgumentsImplCopyWith<_$MutedPageArgumentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
