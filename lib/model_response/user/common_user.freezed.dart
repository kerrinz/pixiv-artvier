// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommonUser _$CommonUserFromJson(Map<String, dynamic> json) {
  return _CommonUser.fromJson(json);
}

/// @nodoc
mixin _$CommonUser {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "account")
  String? get account => throw _privateConstructorUsedError;
  @JsonKey(name: "profile_image_urls")
  Profile_image_urls get profileImageUrls => throw _privateConstructorUsedError;

  /// 只在用户详情中存在该字段
  @JsonKey(name: "comment")
  String? get comment => throw _privateConstructorUsedError;

  /// 已删除或不公开的图片会不存在此字段
  @JsonKey(name: "is_followed")
  bool? get isFollowed => throw _privateConstructorUsedError;

  /// ？？？
  @JsonKey(name: 'is_accept_request')
  bool? get isAcceptRequest => throw _privateConstructorUsedError;

  /// 是否屏蔽
  @JsonKey(name: 'is_access_blocking_user')
  bool? get isAccessBlockingUser => throw _privateConstructorUsedError;

  /// Serializes this CommonUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommonUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommonUserCopyWith<CommonUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommonUserCopyWith<$Res> {
  factory $CommonUserCopyWith(
          CommonUser value, $Res Function(CommonUser) then) =
      _$CommonUserCopyWithImpl<$Res, CommonUser>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "account") String? account,
      @JsonKey(name: "profile_image_urls") Profile_image_urls profileImageUrls,
      @JsonKey(name: "comment") String? comment,
      @JsonKey(name: "is_followed") bool? isFollowed,
      @JsonKey(name: 'is_accept_request') bool? isAcceptRequest,
      @JsonKey(name: 'is_access_blocking_user') bool? isAccessBlockingUser});

  $Profile_image_urlsCopyWith<$Res> get profileImageUrls;
}

/// @nodoc
class _$CommonUserCopyWithImpl<$Res, $Val extends CommonUser>
    implements $CommonUserCopyWith<$Res> {
  _$CommonUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommonUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? account = freezed,
    Object? profileImageUrls = null,
    Object? comment = freezed,
    Object? isFollowed = freezed,
    Object? isAcceptRequest = freezed,
    Object? isAccessBlockingUser = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrls: null == profileImageUrls
          ? _value.profileImageUrls
          : profileImageUrls // ignore: cast_nullable_to_non_nullable
              as Profile_image_urls,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      isFollowed: freezed == isFollowed
          ? _value.isFollowed
          : isFollowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAcceptRequest: freezed == isAcceptRequest
          ? _value.isAcceptRequest
          : isAcceptRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAccessBlockingUser: freezed == isAccessBlockingUser
          ? _value.isAccessBlockingUser
          : isAccessBlockingUser // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of CommonUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Profile_image_urlsCopyWith<$Res> get profileImageUrls {
    return $Profile_image_urlsCopyWith<$Res>(_value.profileImageUrls, (value) {
      return _then(_value.copyWith(profileImageUrls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CommonUserImplCopyWith<$Res>
    implements $CommonUserCopyWith<$Res> {
  factory _$$CommonUserImplCopyWith(
          _$CommonUserImpl value, $Res Function(_$CommonUserImpl) then) =
      __$$CommonUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "account") String? account,
      @JsonKey(name: "profile_image_urls") Profile_image_urls profileImageUrls,
      @JsonKey(name: "comment") String? comment,
      @JsonKey(name: "is_followed") bool? isFollowed,
      @JsonKey(name: 'is_accept_request') bool? isAcceptRequest,
      @JsonKey(name: 'is_access_blocking_user') bool? isAccessBlockingUser});

  @override
  $Profile_image_urlsCopyWith<$Res> get profileImageUrls;
}

/// @nodoc
class __$$CommonUserImplCopyWithImpl<$Res>
    extends _$CommonUserCopyWithImpl<$Res, _$CommonUserImpl>
    implements _$$CommonUserImplCopyWith<$Res> {
  __$$CommonUserImplCopyWithImpl(
      _$CommonUserImpl _value, $Res Function(_$CommonUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommonUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? account = freezed,
    Object? profileImageUrls = null,
    Object? comment = freezed,
    Object? isFollowed = freezed,
    Object? isAcceptRequest = freezed,
    Object? isAccessBlockingUser = freezed,
  }) {
    return _then(_$CommonUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrls: null == profileImageUrls
          ? _value.profileImageUrls
          : profileImageUrls // ignore: cast_nullable_to_non_nullable
              as Profile_image_urls,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      isFollowed: freezed == isFollowed
          ? _value.isFollowed
          : isFollowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAcceptRequest: freezed == isAcceptRequest
          ? _value.isAcceptRequest
          : isAcceptRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAccessBlockingUser: freezed == isAccessBlockingUser
          ? _value.isAccessBlockingUser
          : isAccessBlockingUser // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommonUserImpl implements _CommonUser {
  const _$CommonUserImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "account") this.account,
      @JsonKey(name: "profile_image_urls") required this.profileImageUrls,
      @JsonKey(name: "comment") this.comment,
      @JsonKey(name: "is_followed") this.isFollowed,
      @JsonKey(name: 'is_accept_request') this.isAcceptRequest,
      @JsonKey(name: 'is_access_blocking_user') this.isAccessBlockingUser});

  factory _$CommonUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommonUserImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "account")
  final String? account;
  @override
  @JsonKey(name: "profile_image_urls")
  final Profile_image_urls profileImageUrls;

  /// 只在用户详情中存在该字段
  @override
  @JsonKey(name: "comment")
  final String? comment;

  /// 已删除或不公开的图片会不存在此字段
  @override
  @JsonKey(name: "is_followed")
  final bool? isFollowed;

  /// ？？？
  @override
  @JsonKey(name: 'is_accept_request')
  final bool? isAcceptRequest;

  /// 是否屏蔽
  @override
  @JsonKey(name: 'is_access_blocking_user')
  final bool? isAccessBlockingUser;

  @override
  String toString() {
    return 'CommonUser(id: $id, name: $name, account: $account, profileImageUrls: $profileImageUrls, comment: $comment, isFollowed: $isFollowed, isAcceptRequest: $isAcceptRequest, isAccessBlockingUser: $isAccessBlockingUser)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommonUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.profileImageUrls, profileImageUrls) ||
                other.profileImageUrls == profileImageUrls) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.isFollowed, isFollowed) ||
                other.isFollowed == isFollowed) &&
            (identical(other.isAcceptRequest, isAcceptRequest) ||
                other.isAcceptRequest == isAcceptRequest) &&
            (identical(other.isAccessBlockingUser, isAccessBlockingUser) ||
                other.isAccessBlockingUser == isAccessBlockingUser));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      account,
      profileImageUrls,
      comment,
      isFollowed,
      isAcceptRequest,
      isAccessBlockingUser);

  /// Create a copy of CommonUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommonUserImplCopyWith<_$CommonUserImpl> get copyWith =>
      __$$CommonUserImplCopyWithImpl<_$CommonUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommonUserImplToJson(
      this,
    );
  }
}

abstract class _CommonUser implements CommonUser {
  const factory _CommonUser(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "account") final String? account,
      @JsonKey(name: "profile_image_urls")
      required final Profile_image_urls profileImageUrls,
      @JsonKey(name: "comment") final String? comment,
      @JsonKey(name: "is_followed") final bool? isFollowed,
      @JsonKey(name: 'is_accept_request') final bool? isAcceptRequest,
      @JsonKey(name: 'is_access_blocking_user')
      final bool? isAccessBlockingUser}) = _$CommonUserImpl;

  factory _CommonUser.fromJson(Map<String, dynamic> json) =
      _$CommonUserImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "account")
  String? get account;
  @override
  @JsonKey(name: "profile_image_urls")
  Profile_image_urls get profileImageUrls;

  /// 只在用户详情中存在该字段
  @override
  @JsonKey(name: "comment")
  String? get comment;

  /// 已删除或不公开的图片会不存在此字段
  @override
  @JsonKey(name: "is_followed")
  bool? get isFollowed;

  /// ？？？
  @override
  @JsonKey(name: 'is_accept_request')
  bool? get isAcceptRequest;

  /// 是否屏蔽
  @override
  @JsonKey(name: 'is_access_blocking_user')
  bool? get isAccessBlockingUser;

  /// Create a copy of CommonUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommonUserImplCopyWith<_$CommonUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Profile_image_urls _$Profile_image_urlsFromJson(Map<String, dynamic> json) {
  return _Profile_image_urls.fromJson(json);
}

/// @nodoc
mixin _$Profile_image_urls {
  @JsonKey(name: 'medium')
  String get medium => throw _privateConstructorUsedError;

  /// Serializes this Profile_image_urls to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Profile_image_urls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Profile_image_urlsCopyWith<Profile_image_urls> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Profile_image_urlsCopyWith<$Res> {
  factory $Profile_image_urlsCopyWith(
          Profile_image_urls value, $Res Function(Profile_image_urls) then) =
      _$Profile_image_urlsCopyWithImpl<$Res, Profile_image_urls>;
  @useResult
  $Res call({@JsonKey(name: 'medium') String medium});
}

/// @nodoc
class _$Profile_image_urlsCopyWithImpl<$Res, $Val extends Profile_image_urls>
    implements $Profile_image_urlsCopyWith<$Res> {
  _$Profile_image_urlsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Profile_image_urls
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
abstract class _$$Profile_image_urlsImplCopyWith<$Res>
    implements $Profile_image_urlsCopyWith<$Res> {
  factory _$$Profile_image_urlsImplCopyWith(_$Profile_image_urlsImpl value,
          $Res Function(_$Profile_image_urlsImpl) then) =
      __$$Profile_image_urlsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'medium') String medium});
}

/// @nodoc
class __$$Profile_image_urlsImplCopyWithImpl<$Res>
    extends _$Profile_image_urlsCopyWithImpl<$Res, _$Profile_image_urlsImpl>
    implements _$$Profile_image_urlsImplCopyWith<$Res> {
  __$$Profile_image_urlsImplCopyWithImpl(_$Profile_image_urlsImpl _value,
      $Res Function(_$Profile_image_urlsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Profile_image_urls
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? medium = null,
  }) {
    return _then(_$Profile_image_urlsImpl(
      medium: null == medium
          ? _value.medium
          : medium // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Profile_image_urlsImpl implements _Profile_image_urls {
  const _$Profile_image_urlsImpl(
      {@JsonKey(name: 'medium') required this.medium});

  factory _$Profile_image_urlsImpl.fromJson(Map<String, dynamic> json) =>
      _$$Profile_image_urlsImplFromJson(json);

  @override
  @JsonKey(name: 'medium')
  final String medium;

  @override
  String toString() {
    return 'Profile_image_urls(medium: $medium)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Profile_image_urlsImpl &&
            (identical(other.medium, medium) || other.medium == medium));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, medium);

  /// Create a copy of Profile_image_urls
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Profile_image_urlsImplCopyWith<_$Profile_image_urlsImpl> get copyWith =>
      __$$Profile_image_urlsImplCopyWithImpl<_$Profile_image_urlsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Profile_image_urlsImplToJson(
      this,
    );
  }
}

abstract class _Profile_image_urls implements Profile_image_urls {
  const factory _Profile_image_urls(
          {@JsonKey(name: 'medium') required final String medium}) =
      _$Profile_image_urlsImpl;

  factory _Profile_image_urls.fromJson(Map<String, dynamic> json) =
      _$Profile_image_urlsImpl.fromJson;

  @override
  @JsonKey(name: 'medium')
  String get medium;

  /// Create a copy of Profile_image_urls
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Profile_image_urlsImplCopyWith<_$Profile_image_urlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
