// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blocking_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BlockingListResponse _$BlockingListResponseFromJson(Map<String, dynamic> json) {
  return _BlockingListResponse.fromJson(json);
}

/// @nodoc
mixin _$BlockingListResponse {
  @JsonKey(name: "muted_tags")
  List<dynamic> get mutedTags => throw _privateConstructorUsedError;
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

  /// Serializes this BlockingListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BlockingListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BlockingListResponseCopyWith<BlockingListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockingListResponseCopyWith<$Res> {
  factory $BlockingListResponseCopyWith(BlockingListResponse value,
          $Res Function(BlockingListResponse) then) =
      _$BlockingListResponseCopyWithImpl<$Res, BlockingListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "muted_tags") List<dynamic> mutedTags,
      @JsonKey(name: "muted_users") List<MutedUser> mutedUsers,
      @JsonKey(name: "muted_count") int mutedCount,
      @JsonKey(name: "muted_tags_count") int mutedTagsCount,
      @JsonKey(name: "muted_users_count") int mutedUsersCount,
      @JsonKey(name: "mute_limit_count") int muteLimitCount,
      @JsonKey(name: "for_text") ForText forText});

  $ForTextCopyWith<$Res> get forText;
}

/// @nodoc
class _$BlockingListResponseCopyWithImpl<$Res,
        $Val extends BlockingListResponse>
    implements $BlockingListResponseCopyWith<$Res> {
  _$BlockingListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BlockingListResponse
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
              as List<dynamic>,
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

  /// Create a copy of BlockingListResponse
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
abstract class _$$BlockingListResponseImplCopyWith<$Res>
    implements $BlockingListResponseCopyWith<$Res> {
  factory _$$BlockingListResponseImplCopyWith(_$BlockingListResponseImpl value,
          $Res Function(_$BlockingListResponseImpl) then) =
      __$$BlockingListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "muted_tags") List<dynamic> mutedTags,
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
class __$$BlockingListResponseImplCopyWithImpl<$Res>
    extends _$BlockingListResponseCopyWithImpl<$Res, _$BlockingListResponseImpl>
    implements _$$BlockingListResponseImplCopyWith<$Res> {
  __$$BlockingListResponseImplCopyWithImpl(_$BlockingListResponseImpl _value,
      $Res Function(_$BlockingListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of BlockingListResponse
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
    return _then(_$BlockingListResponseImpl(
      mutedTags: null == mutedTags
          ? _value._mutedTags
          : mutedTags // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
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
class _$BlockingListResponseImpl implements _BlockingListResponse {
  const _$BlockingListResponseImpl(
      {@JsonKey(name: "muted_tags") required final List<dynamic> mutedTags,
      @JsonKey(name: "muted_users") required final List<MutedUser> mutedUsers,
      @JsonKey(name: "muted_count") required this.mutedCount,
      @JsonKey(name: "muted_tags_count") required this.mutedTagsCount,
      @JsonKey(name: "muted_users_count") required this.mutedUsersCount,
      @JsonKey(name: "mute_limit_count") required this.muteLimitCount,
      @JsonKey(name: "for_text") required this.forText})
      : _mutedTags = mutedTags,
        _mutedUsers = mutedUsers;

  factory _$BlockingListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockingListResponseImplFromJson(json);

  final List<dynamic> _mutedTags;
  @override
  @JsonKey(name: "muted_tags")
  List<dynamic> get mutedTags {
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
    return 'BlockingListResponse(mutedTags: $mutedTags, mutedUsers: $mutedUsers, mutedCount: $mutedCount, mutedTagsCount: $mutedTagsCount, mutedUsersCount: $mutedUsersCount, muteLimitCount: $muteLimitCount, forText: $forText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockingListResponseImpl &&
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

  /// Create a copy of BlockingListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockingListResponseImplCopyWith<_$BlockingListResponseImpl>
      get copyWith =>
          __$$BlockingListResponseImplCopyWithImpl<_$BlockingListResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockingListResponseImplToJson(
      this,
    );
  }
}

abstract class _BlockingListResponse implements BlockingListResponse {
  const factory _BlockingListResponse(
      {@JsonKey(name: "muted_tags") required final List<dynamic> mutedTags,
      @JsonKey(name: "muted_users") required final List<MutedUser> mutedUsers,
      @JsonKey(name: "muted_count") required final int mutedCount,
      @JsonKey(name: "muted_tags_count") required final int mutedTagsCount,
      @JsonKey(name: "muted_users_count") required final int mutedUsersCount,
      @JsonKey(name: "mute_limit_count") required final int muteLimitCount,
      @JsonKey(name: "for_text")
      required final ForText forText}) = _$BlockingListResponseImpl;

  factory _BlockingListResponse.fromJson(Map<String, dynamic> json) =
      _$BlockingListResponseImpl.fromJson;

  @override
  @JsonKey(name: "muted_tags")
  List<dynamic> get mutedTags;
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

  /// Create a copy of BlockingListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BlockingListResponseImplCopyWith<_$BlockingListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
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
