// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'muted_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MutedListResponse _$MutedListResponseFromJson(Map<String, dynamic> json) {
  return _MutedListResponse.fromJson(json);
}

/// @nodoc
mixin _$MutedListResponse {
  @JsonKey(name: "muted_tags")
  List<MutedTag> get mutedTags => throw _privateConstructorUsedError;
  @JsonKey(name: "muted_users")
  List<MutedUser> get mutedUsers => throw _privateConstructorUsedError;
  @JsonKey(name: "muted_count")
  int get mutedCount => throw _privateConstructorUsedError;
  @JsonKey(name: "muted_tags_count")
  int get mutedTagsCount => throw _privateConstructorUsedError;
  @JsonKey(name: "muted_users_count")
  int get mutedUsersCount => throw _privateConstructorUsedError;
  @JsonKey(name: "mute_limit_count")
  int get muteLimitCount => throw _privateConstructorUsedError;
  @JsonKey(name: "for_text")
  ForText get forText => throw _privateConstructorUsedError;

  /// Serializes this MutedListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MutedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MutedListResponseCopyWith<MutedListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MutedListResponseCopyWith<$Res> {
  factory $MutedListResponseCopyWith(
          MutedListResponse value, $Res Function(MutedListResponse) then) =
      _$MutedListResponseCopyWithImpl<$Res, MutedListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "muted_tags") List<MutedTag> mutedTags,
      @JsonKey(name: "muted_users") List<MutedUser> mutedUsers,
      @JsonKey(name: "muted_count") int mutedCount,
      @JsonKey(name: "muted_tags_count") int mutedTagsCount,
      @JsonKey(name: "muted_users_count") int mutedUsersCount,
      @JsonKey(name: "mute_limit_count") int muteLimitCount,
      @JsonKey(name: "for_text") ForText forText});

  $ForTextCopyWith<$Res> get forText;
}

/// @nodoc
class _$MutedListResponseCopyWithImpl<$Res, $Val extends MutedListResponse>
    implements $MutedListResponseCopyWith<$Res> {
  _$MutedListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MutedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mutedTags = null,
    Object? mutedUsers = null,
    Object? mutedCount = null,
    Object? mutedTagsCount = null,
    Object? mutedUsersCount = null,
    Object? muteLimitCount = null,
    Object? forText = null,
  }) {
    return _then(_value.copyWith(
      mutedTags: null == mutedTags
          ? _value.mutedTags
          : mutedTags // ignore: cast_nullable_to_non_nullable
              as List<MutedTag>,
      mutedUsers: null == mutedUsers
          ? _value.mutedUsers
          : mutedUsers // ignore: cast_nullable_to_non_nullable
              as List<MutedUser>,
      mutedCount: null == mutedCount
          ? _value.mutedCount
          : mutedCount // ignore: cast_nullable_to_non_nullable
              as int,
      mutedTagsCount: null == mutedTagsCount
          ? _value.mutedTagsCount
          : mutedTagsCount // ignore: cast_nullable_to_non_nullable
              as int,
      mutedUsersCount: null == mutedUsersCount
          ? _value.mutedUsersCount
          : mutedUsersCount // ignore: cast_nullable_to_non_nullable
              as int,
      muteLimitCount: null == muteLimitCount
          ? _value.muteLimitCount
          : muteLimitCount // ignore: cast_nullable_to_non_nullable
              as int,
      forText: null == forText
          ? _value.forText
          : forText // ignore: cast_nullable_to_non_nullable
              as ForText,
    ) as $Val);
  }

  /// Create a copy of MutedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForTextCopyWith<$Res> get forText {
    return $ForTextCopyWith<$Res>(_value.forText, (value) {
      return _then(_value.copyWith(forText: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MutedListResponseImplCopyWith<$Res>
    implements $MutedListResponseCopyWith<$Res> {
  factory _$$MutedListResponseImplCopyWith(_$MutedListResponseImpl value,
          $Res Function(_$MutedListResponseImpl) then) =
      __$$MutedListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "muted_tags") List<MutedTag> mutedTags,
      @JsonKey(name: "muted_users") List<MutedUser> mutedUsers,
      @JsonKey(name: "muted_count") int mutedCount,
      @JsonKey(name: "muted_tags_count") int mutedTagsCount,
      @JsonKey(name: "muted_users_count") int mutedUsersCount,
      @JsonKey(name: "mute_limit_count") int muteLimitCount,
      @JsonKey(name: "for_text") ForText forText});

  @override
  $ForTextCopyWith<$Res> get forText;
}

/// @nodoc
class __$$MutedListResponseImplCopyWithImpl<$Res>
    extends _$MutedListResponseCopyWithImpl<$Res, _$MutedListResponseImpl>
    implements _$$MutedListResponseImplCopyWith<$Res> {
  __$$MutedListResponseImplCopyWithImpl(_$MutedListResponseImpl _value,
      $Res Function(_$MutedListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of MutedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mutedTags = null,
    Object? mutedUsers = null,
    Object? mutedCount = null,
    Object? mutedTagsCount = null,
    Object? mutedUsersCount = null,
    Object? muteLimitCount = null,
    Object? forText = null,
  }) {
    return _then(_$MutedListResponseImpl(
      mutedTags: null == mutedTags
          ? _value._mutedTags
          : mutedTags // ignore: cast_nullable_to_non_nullable
              as List<MutedTag>,
      mutedUsers: null == mutedUsers
          ? _value._mutedUsers
          : mutedUsers // ignore: cast_nullable_to_non_nullable
              as List<MutedUser>,
      mutedCount: null == mutedCount
          ? _value.mutedCount
          : mutedCount // ignore: cast_nullable_to_non_nullable
              as int,
      mutedTagsCount: null == mutedTagsCount
          ? _value.mutedTagsCount
          : mutedTagsCount // ignore: cast_nullable_to_non_nullable
              as int,
      mutedUsersCount: null == mutedUsersCount
          ? _value.mutedUsersCount
          : mutedUsersCount // ignore: cast_nullable_to_non_nullable
              as int,
      muteLimitCount: null == muteLimitCount
          ? _value.muteLimitCount
          : muteLimitCount // ignore: cast_nullable_to_non_nullable
              as int,
      forText: null == forText
          ? _value.forText
          : forText // ignore: cast_nullable_to_non_nullable
              as ForText,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MutedListResponseImpl implements _MutedListResponse {
  const _$MutedListResponseImpl(
      {@JsonKey(name: "muted_tags") required final List<MutedTag> mutedTags,
      @JsonKey(name: "muted_users") required final List<MutedUser> mutedUsers,
      @JsonKey(name: "muted_count") required this.mutedCount,
      @JsonKey(name: "muted_tags_count") required this.mutedTagsCount,
      @JsonKey(name: "muted_users_count") required this.mutedUsersCount,
      @JsonKey(name: "mute_limit_count") required this.muteLimitCount,
      @JsonKey(name: "for_text") required this.forText})
      : _mutedTags = mutedTags,
        _mutedUsers = mutedUsers;

  factory _$MutedListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MutedListResponseImplFromJson(json);

  final List<MutedTag> _mutedTags;
  @override
  @JsonKey(name: "muted_tags")
  List<MutedTag> get mutedTags {
    if (_mutedTags is EqualUnmodifiableListView) return _mutedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mutedTags);
  }

  final List<MutedUser> _mutedUsers;
  @override
  @JsonKey(name: "muted_users")
  List<MutedUser> get mutedUsers {
    if (_mutedUsers is EqualUnmodifiableListView) return _mutedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mutedUsers);
  }

  @override
  @JsonKey(name: "muted_count")
  final int mutedCount;
  @override
  @JsonKey(name: "muted_tags_count")
  final int mutedTagsCount;
  @override
  @JsonKey(name: "muted_users_count")
  final int mutedUsersCount;
  @override
  @JsonKey(name: "mute_limit_count")
  final int muteLimitCount;
  @override
  @JsonKey(name: "for_text")
  final ForText forText;

  @override
  String toString() {
    return 'MutedListResponse(mutedTags: $mutedTags, mutedUsers: $mutedUsers, mutedCount: $mutedCount, mutedTagsCount: $mutedTagsCount, mutedUsersCount: $mutedUsersCount, muteLimitCount: $muteLimitCount, forText: $forText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MutedListResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._mutedTags, _mutedTags) &&
            const DeepCollectionEquality()
                .equals(other._mutedUsers, _mutedUsers) &&
            (identical(other.mutedCount, mutedCount) ||
                other.mutedCount == mutedCount) &&
            (identical(other.mutedTagsCount, mutedTagsCount) ||
                other.mutedTagsCount == mutedTagsCount) &&
            (identical(other.mutedUsersCount, mutedUsersCount) ||
                other.mutedUsersCount == mutedUsersCount) &&
            (identical(other.muteLimitCount, muteLimitCount) ||
                other.muteLimitCount == muteLimitCount) &&
            (identical(other.forText, forText) || other.forText == forText));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_mutedTags),
      const DeepCollectionEquality().hash(_mutedUsers),
      mutedCount,
      mutedTagsCount,
      mutedUsersCount,
      muteLimitCount,
      forText);

  /// Create a copy of MutedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MutedListResponseImplCopyWith<_$MutedListResponseImpl> get copyWith =>
      __$$MutedListResponseImplCopyWithImpl<_$MutedListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MutedListResponseImplToJson(
      this,
    );
  }
}

abstract class _MutedListResponse implements MutedListResponse {
  const factory _MutedListResponse(
      {@JsonKey(name: "muted_tags") required final List<MutedTag> mutedTags,
      @JsonKey(name: "muted_users") required final List<MutedUser> mutedUsers,
      @JsonKey(name: "muted_count") required final int mutedCount,
      @JsonKey(name: "muted_tags_count") required final int mutedTagsCount,
      @JsonKey(name: "muted_users_count") required final int mutedUsersCount,
      @JsonKey(name: "mute_limit_count") required final int muteLimitCount,
      @JsonKey(name: "for_text")
      required final ForText forText}) = _$MutedListResponseImpl;

  factory _MutedListResponse.fromJson(Map<String, dynamic> json) =
      _$MutedListResponseImpl.fromJson;

  @override
  @JsonKey(name: "muted_tags")
  List<MutedTag> get mutedTags;
  @override
  @JsonKey(name: "muted_users")
  List<MutedUser> get mutedUsers;
  @override
  @JsonKey(name: "muted_count")
  int get mutedCount;
  @override
  @JsonKey(name: "muted_tags_count")
  int get mutedTagsCount;
  @override
  @JsonKey(name: "muted_users_count")
  int get mutedUsersCount;
  @override
  @JsonKey(name: "mute_limit_count")
  int get muteLimitCount;
  @override
  @JsonKey(name: "for_text")
  ForText get forText;

  /// Create a copy of MutedListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MutedListResponseImplCopyWith<_$MutedListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForText _$ForTextFromJson(Map<String, dynamic> json) {
  return _ForText.fromJson(json);
}

/// @nodoc
mixin _$ForText {
  @JsonKey(name: "mute_limit_count_if_no_premium")
  int get muteLimitCountIfNoPremium => throw _privateConstructorUsedError;
  @JsonKey(name: "mute_limit_count_if_premium")
  int get muteLimitCountIfPremium => throw _privateConstructorUsedError;

  /// Serializes this ForText to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForText
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForTextCopyWith<ForText> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForTextCopyWith<$Res> {
  factory $ForTextCopyWith(ForText value, $Res Function(ForText) then) =
      _$ForTextCopyWithImpl<$Res, ForText>;
  @useResult
  $Res call(
      {@JsonKey(name: "mute_limit_count_if_no_premium")
      int muteLimitCountIfNoPremium,
      @JsonKey(name: "mute_limit_count_if_premium")
      int muteLimitCountIfPremium});
}

/// @nodoc
class _$ForTextCopyWithImpl<$Res, $Val extends ForText>
    implements $ForTextCopyWith<$Res> {
  _$ForTextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForText
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? muteLimitCountIfNoPremium = null,
    Object? muteLimitCountIfPremium = null,
  }) {
    return _then(_value.copyWith(
      muteLimitCountIfNoPremium: null == muteLimitCountIfNoPremium
          ? _value.muteLimitCountIfNoPremium
          : muteLimitCountIfNoPremium // ignore: cast_nullable_to_non_nullable
              as int,
      muteLimitCountIfPremium: null == muteLimitCountIfPremium
          ? _value.muteLimitCountIfPremium
          : muteLimitCountIfPremium // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForTextImplCopyWith<$Res> implements $ForTextCopyWith<$Res> {
  factory _$$ForTextImplCopyWith(
          _$ForTextImpl value, $Res Function(_$ForTextImpl) then) =
      __$$ForTextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "mute_limit_count_if_no_premium")
      int muteLimitCountIfNoPremium,
      @JsonKey(name: "mute_limit_count_if_premium")
      int muteLimitCountIfPremium});
}

/// @nodoc
class __$$ForTextImplCopyWithImpl<$Res>
    extends _$ForTextCopyWithImpl<$Res, _$ForTextImpl>
    implements _$$ForTextImplCopyWith<$Res> {
  __$$ForTextImplCopyWithImpl(
      _$ForTextImpl _value, $Res Function(_$ForTextImpl) _then)
      : super(_value, _then);

  /// Create a copy of ForText
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? muteLimitCountIfNoPremium = null,
    Object? muteLimitCountIfPremium = null,
  }) {
    return _then(_$ForTextImpl(
      muteLimitCountIfNoPremium: null == muteLimitCountIfNoPremium
          ? _value.muteLimitCountIfNoPremium
          : muteLimitCountIfNoPremium // ignore: cast_nullable_to_non_nullable
              as int,
      muteLimitCountIfPremium: null == muteLimitCountIfPremium
          ? _value.muteLimitCountIfPremium
          : muteLimitCountIfPremium // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForTextImpl implements _ForText {
  const _$ForTextImpl(
      {@JsonKey(name: "mute_limit_count_if_no_premium")
      required this.muteLimitCountIfNoPremium,
      @JsonKey(name: "mute_limit_count_if_premium")
      required this.muteLimitCountIfPremium});

  factory _$ForTextImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForTextImplFromJson(json);

  @override
  @JsonKey(name: "mute_limit_count_if_no_premium")
  final int muteLimitCountIfNoPremium;
  @override
  @JsonKey(name: "mute_limit_count_if_premium")
  final int muteLimitCountIfPremium;

  @override
  String toString() {
    return 'ForText(muteLimitCountIfNoPremium: $muteLimitCountIfNoPremium, muteLimitCountIfPremium: $muteLimitCountIfPremium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForTextImpl &&
            (identical(other.muteLimitCountIfNoPremium,
                    muteLimitCountIfNoPremium) ||
                other.muteLimitCountIfNoPremium == muteLimitCountIfNoPremium) &&
            (identical(
                    other.muteLimitCountIfPremium, muteLimitCountIfPremium) ||
                other.muteLimitCountIfPremium == muteLimitCountIfPremium));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, muteLimitCountIfNoPremium, muteLimitCountIfPremium);

  /// Create a copy of ForText
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForTextImplCopyWith<_$ForTextImpl> get copyWith =>
      __$$ForTextImplCopyWithImpl<_$ForTextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForTextImplToJson(
      this,
    );
  }
}

abstract class _ForText implements ForText {
  const factory _ForText(
      {@JsonKey(name: "mute_limit_count_if_no_premium")
      required final int muteLimitCountIfNoPremium,
      @JsonKey(name: "mute_limit_count_if_premium")
      required final int muteLimitCountIfPremium}) = _$ForTextImpl;

  factory _ForText.fromJson(Map<String, dynamic> json) = _$ForTextImpl.fromJson;

  @override
  @JsonKey(name: "mute_limit_count_if_no_premium")
  int get muteLimitCountIfNoPremium;
  @override
  @JsonKey(name: "mute_limit_count_if_premium")
  int get muteLimitCountIfPremium;

  /// Create a copy of ForText
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForTextImplCopyWith<_$ForTextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MutedUser _$MutedUserFromJson(Map<String, dynamic> json) {
  return _MutedUser.fromJson(json);
}

/// @nodoc
mixin _$MutedUser {
  @JsonKey(name: "user")
  CommonUser get user => throw _privateConstructorUsedError;
  @JsonKey(name: "is_premium_slot")
  bool get isPremiumSlot => throw _privateConstructorUsedError;

  /// Serializes this MutedUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MutedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MutedUserCopyWith<MutedUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MutedUserCopyWith<$Res> {
  factory $MutedUserCopyWith(MutedUser value, $Res Function(MutedUser) then) =
      _$MutedUserCopyWithImpl<$Res, MutedUser>;
  @useResult
  $Res call(
      {@JsonKey(name: "user") CommonUser user,
      @JsonKey(name: "is_premium_slot") bool isPremiumSlot});

  $CommonUserCopyWith<$Res> get user;
}

/// @nodoc
class _$MutedUserCopyWithImpl<$Res, $Val extends MutedUser>
    implements $MutedUserCopyWith<$Res> {
  _$MutedUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MutedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? isPremiumSlot = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CommonUser,
      isPremiumSlot: null == isPremiumSlot
          ? _value.isPremiumSlot
          : isPremiumSlot // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of MutedUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CommonUserCopyWith<$Res> get user {
    return $CommonUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MutedUserImplCopyWith<$Res>
    implements $MutedUserCopyWith<$Res> {
  factory _$$MutedUserImplCopyWith(
          _$MutedUserImpl value, $Res Function(_$MutedUserImpl) then) =
      __$$MutedUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "user") CommonUser user,
      @JsonKey(name: "is_premium_slot") bool isPremiumSlot});

  @override
  $CommonUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$MutedUserImplCopyWithImpl<$Res>
    extends _$MutedUserCopyWithImpl<$Res, _$MutedUserImpl>
    implements _$$MutedUserImplCopyWith<$Res> {
  __$$MutedUserImplCopyWithImpl(
      _$MutedUserImpl _value, $Res Function(_$MutedUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of MutedUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? isPremiumSlot = null,
  }) {
    return _then(_$MutedUserImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as CommonUser,
      isPremiumSlot: null == isPremiumSlot
          ? _value.isPremiumSlot
          : isPremiumSlot // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MutedUserImpl implements _MutedUser {
  const _$MutedUserImpl(
      {@JsonKey(name: "user") required this.user,
      @JsonKey(name: "is_premium_slot") required this.isPremiumSlot});

  factory _$MutedUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$MutedUserImplFromJson(json);

  @override
  @JsonKey(name: "user")
  final CommonUser user;
  @override
  @JsonKey(name: "is_premium_slot")
  final bool isPremiumSlot;

  @override
  String toString() {
    return 'MutedUser(user: $user, isPremiumSlot: $isPremiumSlot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MutedUserImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.isPremiumSlot, isPremiumSlot) ||
                other.isPremiumSlot == isPremiumSlot));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, isPremiumSlot);

  /// Create a copy of MutedUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MutedUserImplCopyWith<_$MutedUserImpl> get copyWith =>
      __$$MutedUserImplCopyWithImpl<_$MutedUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MutedUserImplToJson(
      this,
    );
  }
}

abstract class _MutedUser implements MutedUser {
  const factory _MutedUser(
      {@JsonKey(name: "user") required final CommonUser user,
      @JsonKey(name: "is_premium_slot")
      required final bool isPremiumSlot}) = _$MutedUserImpl;

  factory _MutedUser.fromJson(Map<String, dynamic> json) =
      _$MutedUserImpl.fromJson;

  @override
  @JsonKey(name: "user")
  CommonUser get user;
  @override
  @JsonKey(name: "is_premium_slot")
  bool get isPremiumSlot;

  /// Create a copy of MutedUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MutedUserImplCopyWith<_$MutedUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MutedTag _$MutedTagFromJson(Map<String, dynamic> json) {
  return _MutedTag.fromJson(json);
}

/// @nodoc
mixin _$MutedTag {
  @JsonKey(name: "tag")
  MutedTagInfo get tag => throw _privateConstructorUsedError;
  @JsonKey(name: "is_access_blocking")
  bool? get isAccessBlocking => throw _privateConstructorUsedError;

  /// Serializes this MutedTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MutedTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MutedTagCopyWith<MutedTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MutedTagCopyWith<$Res> {
  factory $MutedTagCopyWith(MutedTag value, $Res Function(MutedTag) then) =
      _$MutedTagCopyWithImpl<$Res, MutedTag>;
  @useResult
  $Res call(
      {@JsonKey(name: "tag") MutedTagInfo tag,
      @JsonKey(name: "is_access_blocking") bool? isAccessBlocking});

  $MutedTagInfoCopyWith<$Res> get tag;
}

/// @nodoc
class _$MutedTagCopyWithImpl<$Res, $Val extends MutedTag>
    implements $MutedTagCopyWith<$Res> {
  _$MutedTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MutedTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag = null,
    Object? isAccessBlocking = freezed,
  }) {
    return _then(_value.copyWith(
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as MutedTagInfo,
      isAccessBlocking: freezed == isAccessBlocking
          ? _value.isAccessBlocking
          : isAccessBlocking // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of MutedTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MutedTagInfoCopyWith<$Res> get tag {
    return $MutedTagInfoCopyWith<$Res>(_value.tag, (value) {
      return _then(_value.copyWith(tag: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MutedTagImplCopyWith<$Res>
    implements $MutedTagCopyWith<$Res> {
  factory _$$MutedTagImplCopyWith(
          _$MutedTagImpl value, $Res Function(_$MutedTagImpl) then) =
      __$$MutedTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "tag") MutedTagInfo tag,
      @JsonKey(name: "is_access_blocking") bool? isAccessBlocking});

  @override
  $MutedTagInfoCopyWith<$Res> get tag;
}

/// @nodoc
class __$$MutedTagImplCopyWithImpl<$Res>
    extends _$MutedTagCopyWithImpl<$Res, _$MutedTagImpl>
    implements _$$MutedTagImplCopyWith<$Res> {
  __$$MutedTagImplCopyWithImpl(
      _$MutedTagImpl _value, $Res Function(_$MutedTagImpl) _then)
      : super(_value, _then);

  /// Create a copy of MutedTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag = null,
    Object? isAccessBlocking = freezed,
  }) {
    return _then(_$MutedTagImpl(
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as MutedTagInfo,
      isAccessBlocking: freezed == isAccessBlocking
          ? _value.isAccessBlocking
          : isAccessBlocking // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MutedTagImpl implements _MutedTag {
  const _$MutedTagImpl(
      {@JsonKey(name: "tag") required this.tag,
      @JsonKey(name: "is_access_blocking") this.isAccessBlocking});

  factory _$MutedTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$MutedTagImplFromJson(json);

  @override
  @JsonKey(name: "tag")
  final MutedTagInfo tag;
  @override
  @JsonKey(name: "is_access_blocking")
  final bool? isAccessBlocking;

  @override
  String toString() {
    return 'MutedTag(tag: $tag, isAccessBlocking: $isAccessBlocking)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MutedTagImpl &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.isAccessBlocking, isAccessBlocking) ||
                other.isAccessBlocking == isAccessBlocking));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, tag, isAccessBlocking);

  /// Create a copy of MutedTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MutedTagImplCopyWith<_$MutedTagImpl> get copyWith =>
      __$$MutedTagImplCopyWithImpl<_$MutedTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MutedTagImplToJson(
      this,
    );
  }
}

abstract class _MutedTag implements MutedTag {
  const factory _MutedTag(
          {@JsonKey(name: "tag") required final MutedTagInfo tag,
          @JsonKey(name: "is_access_blocking") final bool? isAccessBlocking}) =
      _$MutedTagImpl;

  factory _MutedTag.fromJson(Map<String, dynamic> json) =
      _$MutedTagImpl.fromJson;

  @override
  @JsonKey(name: "tag")
  MutedTagInfo get tag;
  @override
  @JsonKey(name: "is_access_blocking")
  bool? get isAccessBlocking;

  /// Create a copy of MutedTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MutedTagImplCopyWith<_$MutedTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MutedTagInfo _$MutedTagInfoFromJson(Map<String, dynamic> json) {
  return _MutedTagInfo.fromJson(json);
}

/// @nodoc
mixin _$MutedTagInfo {
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;

  /// Serializes this MutedTagInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MutedTagInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MutedTagInfoCopyWith<MutedTagInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MutedTagInfoCopyWith<$Res> {
  factory $MutedTagInfoCopyWith(
          MutedTagInfo value, $Res Function(MutedTagInfo) then) =
      _$MutedTagInfoCopyWithImpl<$Res, MutedTagInfo>;
  @useResult
  $Res call({@JsonKey(name: "name") String name});
}

/// @nodoc
class _$MutedTagInfoCopyWithImpl<$Res, $Val extends MutedTagInfo>
    implements $MutedTagInfoCopyWith<$Res> {
  _$MutedTagInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MutedTagInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MutedTagInfoImplCopyWith<$Res>
    implements $MutedTagInfoCopyWith<$Res> {
  factory _$$MutedTagInfoImplCopyWith(
          _$MutedTagInfoImpl value, $Res Function(_$MutedTagInfoImpl) then) =
      __$$MutedTagInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "name") String name});
}

/// @nodoc
class __$$MutedTagInfoImplCopyWithImpl<$Res>
    extends _$MutedTagInfoCopyWithImpl<$Res, _$MutedTagInfoImpl>
    implements _$$MutedTagInfoImplCopyWith<$Res> {
  __$$MutedTagInfoImplCopyWithImpl(
      _$MutedTagInfoImpl _value, $Res Function(_$MutedTagInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of MutedTagInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
  }) {
    return _then(_$MutedTagInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MutedTagInfoImpl implements _MutedTagInfo {
  const _$MutedTagInfoImpl({@JsonKey(name: "name") required this.name});

  factory _$MutedTagInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MutedTagInfoImplFromJson(json);

  @override
  @JsonKey(name: "name")
  final String name;

  @override
  String toString() {
    return 'MutedTagInfo(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MutedTagInfoImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of MutedTagInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MutedTagInfoImplCopyWith<_$MutedTagInfoImpl> get copyWith =>
      __$$MutedTagInfoImplCopyWithImpl<_$MutedTagInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MutedTagInfoImplToJson(
      this,
    );
  }
}

abstract class _MutedTagInfo implements MutedTagInfo {
  const factory _MutedTagInfo(
      {@JsonKey(name: "name") required final String name}) = _$MutedTagInfoImpl;

  factory _MutedTagInfo.fromJson(Map<String, dynamic> json) =
      _$MutedTagInfoImpl.fromJson;

  @override
  @JsonKey(name: "name")
  String get name;

  /// Create a copy of MutedTagInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MutedTagInfoImplCopyWith<_$MutedTagInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProfileImageUrls _$ProfileImageUrlsFromJson(Map<String, dynamic> json) {
  return _ProfileImageUrls.fromJson(json);
}

/// @nodoc
mixin _$ProfileImageUrls {
  @JsonKey(name: "medium")
  String get medium => throw _privateConstructorUsedError;

  /// Serializes this ProfileImageUrls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileImageUrlsCopyWith<ProfileImageUrls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileImageUrlsCopyWith<$Res> {
  factory $ProfileImageUrlsCopyWith(
          ProfileImageUrls value, $Res Function(ProfileImageUrls) then) =
      _$ProfileImageUrlsCopyWithImpl<$Res, ProfileImageUrls>;
  @useResult
  $Res call({@JsonKey(name: "medium") String medium});
}

/// @nodoc
class _$ProfileImageUrlsCopyWithImpl<$Res, $Val extends ProfileImageUrls>
    implements $ProfileImageUrlsCopyWith<$Res> {
  _$ProfileImageUrlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medium = null,
  }) {
    return _then(_value.copyWith(
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProfileImageUrlsImplCopyWith<$Res>
    implements $ProfileImageUrlsCopyWith<$Res> {
  factory _$$ProfileImageUrlsImplCopyWith(_$ProfileImageUrlsImpl value,
          $Res Function(_$ProfileImageUrlsImpl) then) =
      __$$ProfileImageUrlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "medium") String medium});
}

/// @nodoc
class __$$ProfileImageUrlsImplCopyWithImpl<$Res>
    extends _$ProfileImageUrlsCopyWithImpl<$Res, _$ProfileImageUrlsImpl>
    implements _$$ProfileImageUrlsImplCopyWith<$Res> {
  __$$ProfileImageUrlsImplCopyWithImpl(_$ProfileImageUrlsImpl _value,
      $Res Function(_$ProfileImageUrlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProfileImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medium = null,
  }) {
    return _then(_$ProfileImageUrlsImpl(
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileImageUrlsImpl implements _ProfileImageUrls {
  const _$ProfileImageUrlsImpl({@JsonKey(name: "medium") required this.medium});

  factory _$ProfileImageUrlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileImageUrlsImplFromJson(json);

  @override
  @JsonKey(name: "medium")
  final String medium;

  @override
  String toString() {
    return 'ProfileImageUrls(medium: $medium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileImageUrlsImpl &&
            (identical(other.medium, medium) || other.medium == medium));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, medium);

  /// Create a copy of ProfileImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileImageUrlsImplCopyWith<_$ProfileImageUrlsImpl> get copyWith =>
      __$$ProfileImageUrlsImplCopyWithImpl<_$ProfileImageUrlsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileImageUrlsImplToJson(
      this,
    );
  }
}

abstract class _ProfileImageUrls implements ProfileImageUrls {
  const factory _ProfileImageUrls(
          {@JsonKey(name: "medium") required final String medium}) =
      _$ProfileImageUrlsImpl;

  factory _ProfileImageUrls.fromJson(Map<String, dynamic> json) =
      _$ProfileImageUrlsImpl.fromJson;

  @override
  @JsonKey(name: "medium")
  String get medium;

  /// Create a copy of ProfileImageUrls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileImageUrlsImplCopyWith<_$ProfileImageUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
