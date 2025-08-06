// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_series_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NovelSeriesListResponse _$NovelSeriesListResponseFromJson(
    Map<String, dynamic> json) {
  return _NovelSeriesListResponse.fromJson(json);
}

/// @nodoc
mixin _$NovelSeriesListResponse {
  @JsonKey(name: "series")
  List<NovelSeries> get series => throw _privateConstructorUsedError;
  @JsonKey(name: "next_url")
  String? get nextUrl => throw _privateConstructorUsedError;

  /// Serializes this NovelSeriesListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NovelSeriesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelSeriesListResponseCopyWith<NovelSeriesListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelSeriesListResponseCopyWith<$Res> {
  factory $NovelSeriesListResponseCopyWith(NovelSeriesListResponse value,
          $Res Function(NovelSeriesListResponse) then) =
      _$NovelSeriesListResponseCopyWithImpl<$Res, NovelSeriesListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "series") List<NovelSeries> series,
      @JsonKey(name: "next_url") String? nextUrl});
}

/// @nodoc
class _$NovelSeriesListResponseCopyWithImpl<$Res,
        $Val extends NovelSeriesListResponse>
    implements $NovelSeriesListResponseCopyWith<$Res> {
  _$NovelSeriesListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelSeriesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? series = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_value.copyWith(
      series: null == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as List<NovelSeries>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelSeriesListResponseImplCopyWith<$Res>
    implements $NovelSeriesListResponseCopyWith<$Res> {
  factory _$$NovelSeriesListResponseImplCopyWith(
          _$NovelSeriesListResponseImpl value,
          $Res Function(_$NovelSeriesListResponseImpl) then) =
      __$$NovelSeriesListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "series") List<NovelSeries> series,
      @JsonKey(name: "next_url") String? nextUrl});
}

/// @nodoc
class __$$NovelSeriesListResponseImplCopyWithImpl<$Res>
    extends _$NovelSeriesListResponseCopyWithImpl<$Res,
        _$NovelSeriesListResponseImpl>
    implements _$$NovelSeriesListResponseImplCopyWith<$Res> {
  __$$NovelSeriesListResponseImplCopyWithImpl(
      _$NovelSeriesListResponseImpl _value,
      $Res Function(_$NovelSeriesListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelSeriesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? series = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_$NovelSeriesListResponseImpl(
      series: null == series
          ? _value._series
          : series // ignore: cast_nullable_to_non_nullable
              as List<NovelSeries>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelSeriesListResponseImpl implements _NovelSeriesListResponse {
  const _$NovelSeriesListResponseImpl(
      {@JsonKey(name: "series") required final List<NovelSeries> series,
      @JsonKey(name: "next_url") required this.nextUrl})
      : _series = series;

  factory _$NovelSeriesListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelSeriesListResponseImplFromJson(json);

  final List<NovelSeries> _series;
  @override
  @JsonKey(name: "series")
  List<NovelSeries> get series {
    if (_series is EqualUnmodifiableListView) return _series;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_series);
  }

  @override
  @JsonKey(name: "next_url")
  final String? nextUrl;

  @override
  String toString() {
    return 'NovelSeriesListResponse(series: $series, nextUrl: $nextUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelSeriesListResponseImpl &&
            const DeepCollectionEquality().equals(other._series, _series) &&
            (identical(other.nextUrl, nextUrl) || other.nextUrl == nextUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_series), nextUrl);

  /// Create a copy of NovelSeriesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelSeriesListResponseImplCopyWith<_$NovelSeriesListResponseImpl>
      get copyWith => __$$NovelSeriesListResponseImplCopyWithImpl<
          _$NovelSeriesListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelSeriesListResponseImplToJson(
      this,
    );
  }
}

abstract class _NovelSeriesListResponse implements NovelSeriesListResponse {
  const factory _NovelSeriesListResponse(
          {@JsonKey(name: "series") required final List<NovelSeries> series,
          @JsonKey(name: "next_url") required final String? nextUrl}) =
      _$NovelSeriesListResponseImpl;

  factory _NovelSeriesListResponse.fromJson(Map<String, dynamic> json) =
      _$NovelSeriesListResponseImpl.fromJson;

  @override
  @JsonKey(name: "series")
  List<NovelSeries> get series;
  @override
  @JsonKey(name: "next_url")
  String? get nextUrl;

  /// Create a copy of NovelSeriesListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelSeriesListResponseImplCopyWith<_$NovelSeriesListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NovelSeries _$NovelSeriesFromJson(Map<String, dynamic> json) {
  return _NovelSeries.fromJson(json);
}

/// @nodoc
mixin _$NovelSeries {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "url")
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: "mask_text")
  dynamic get maskText => throw _privateConstructorUsedError;
  @JsonKey(name: "published_content_count")
  int get publishedContentCount => throw _privateConstructorUsedError;
  @JsonKey(name: "last_published_content_datetime")
  DateTime get lastPublishedContentDatetime =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "latest_content_id")
  int get latestContentId => throw _privateConstructorUsedError;
  @JsonKey(name: "user")
  User get user => throw _privateConstructorUsedError;

  /// Serializes this NovelSeries to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NovelSeries
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelSeriesCopyWith<NovelSeries> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelSeriesCopyWith<$Res> {
  factory $NovelSeriesCopyWith(
          NovelSeries value, $Res Function(NovelSeries) then) =
      _$NovelSeriesCopyWithImpl<$Res, NovelSeries>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "url") String url,
      @JsonKey(name: "mask_text") dynamic maskText,
      @JsonKey(name: "published_content_count") int publishedContentCount,
      @JsonKey(name: "last_published_content_datetime")
      DateTime lastPublishedContentDatetime,
      @JsonKey(name: "latest_content_id") int latestContentId,
      @JsonKey(name: "user") User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$NovelSeriesCopyWithImpl<$Res, $Val extends NovelSeries>
    implements $NovelSeriesCopyWith<$Res> {
  _$NovelSeriesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelSeries
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? maskText = freezed,
    Object? publishedContentCount = null,
    Object? lastPublishedContentDatetime = null,
    Object? latestContentId = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      maskText: freezed == maskText
          ? _value.maskText
          : maskText // ignore: cast_nullable_to_non_nullable
              as dynamic,
      publishedContentCount: null == publishedContentCount
          ? _value.publishedContentCount
          : publishedContentCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastPublishedContentDatetime: null == lastPublishedContentDatetime
          ? _value.lastPublishedContentDatetime
          : lastPublishedContentDatetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latestContentId: null == latestContentId
          ? _value.latestContentId
          : latestContentId // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ) as $Val);
  }

  /// Create a copy of NovelSeries
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NovelSeriesImplCopyWith<$Res>
    implements $NovelSeriesCopyWith<$Res> {
  factory _$$NovelSeriesImplCopyWith(
          _$NovelSeriesImpl value, $Res Function(_$NovelSeriesImpl) then) =
      __$$NovelSeriesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "url") String url,
      @JsonKey(name: "mask_text") dynamic maskText,
      @JsonKey(name: "published_content_count") int publishedContentCount,
      @JsonKey(name: "last_published_content_datetime")
      DateTime lastPublishedContentDatetime,
      @JsonKey(name: "latest_content_id") int latestContentId,
      @JsonKey(name: "user") User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$NovelSeriesImplCopyWithImpl<$Res>
    extends _$NovelSeriesCopyWithImpl<$Res, _$NovelSeriesImpl>
    implements _$$NovelSeriesImplCopyWith<$Res> {
  __$$NovelSeriesImplCopyWithImpl(
      _$NovelSeriesImpl _value, $Res Function(_$NovelSeriesImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelSeries
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? maskText = freezed,
    Object? publishedContentCount = null,
    Object? lastPublishedContentDatetime = null,
    Object? latestContentId = null,
    Object? user = null,
  }) {
    return _then(_$NovelSeriesImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      maskText: freezed == maskText
          ? _value.maskText
          : maskText // ignore: cast_nullable_to_non_nullable
              as dynamic,
      publishedContentCount: null == publishedContentCount
          ? _value.publishedContentCount
          : publishedContentCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastPublishedContentDatetime: null == lastPublishedContentDatetime
          ? _value.lastPublishedContentDatetime
          : lastPublishedContentDatetime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latestContentId: null == latestContentId
          ? _value.latestContentId
          : latestContentId // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelSeriesImpl implements _NovelSeries {
  const _$NovelSeriesImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "title") required this.title,
      @JsonKey(name: "url") required this.url,
      @JsonKey(name: "mask_text") required this.maskText,
      @JsonKey(name: "published_content_count")
      required this.publishedContentCount,
      @JsonKey(name: "last_published_content_datetime")
      required this.lastPublishedContentDatetime,
      @JsonKey(name: "latest_content_id") required this.latestContentId,
      @JsonKey(name: "user") required this.user});

  factory _$NovelSeriesImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelSeriesImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "title")
  final String title;
  @override
  @JsonKey(name: "url")
  final String url;
  @override
  @JsonKey(name: "mask_text")
  final dynamic maskText;
  @override
  @JsonKey(name: "published_content_count")
  final int publishedContentCount;
  @override
  @JsonKey(name: "last_published_content_datetime")
  final DateTime lastPublishedContentDatetime;
  @override
  @JsonKey(name: "latest_content_id")
  final int latestContentId;
  @override
  @JsonKey(name: "user")
  final User user;

  @override
  String toString() {
    return 'NovelSeries(id: $id, title: $title, url: $url, maskText: $maskText, publishedContentCount: $publishedContentCount, lastPublishedContentDatetime: $lastPublishedContentDatetime, latestContentId: $latestContentId, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelSeriesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other.maskText, maskText) &&
            (identical(other.publishedContentCount, publishedContentCount) ||
                other.publishedContentCount == publishedContentCount) &&
            (identical(other.lastPublishedContentDatetime,
                    lastPublishedContentDatetime) ||
                other.lastPublishedContentDatetime ==
                    lastPublishedContentDatetime) &&
            (identical(other.latestContentId, latestContentId) ||
                other.latestContentId == latestContentId) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      url,
      const DeepCollectionEquality().hash(maskText),
      publishedContentCount,
      lastPublishedContentDatetime,
      latestContentId,
      user);

  /// Create a copy of NovelSeries
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelSeriesImplCopyWith<_$NovelSeriesImpl> get copyWith =>
      __$$NovelSeriesImplCopyWithImpl<_$NovelSeriesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelSeriesImplToJson(
      this,
    );
  }
}

abstract class _NovelSeries implements NovelSeries {
  const factory _NovelSeries(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "title") required final String title,
      @JsonKey(name: "url") required final String url,
      @JsonKey(name: "mask_text") required final dynamic maskText,
      @JsonKey(name: "published_content_count")
      required final int publishedContentCount,
      @JsonKey(name: "last_published_content_datetime")
      required final DateTime lastPublishedContentDatetime,
      @JsonKey(name: "latest_content_id") required final int latestContentId,
      @JsonKey(name: "user") required final User user}) = _$NovelSeriesImpl;

  factory _NovelSeries.fromJson(Map<String, dynamic> json) =
      _$NovelSeriesImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "title")
  String get title;
  @override
  @JsonKey(name: "url")
  String get url;
  @override
  @JsonKey(name: "mask_text")
  dynamic get maskText;
  @override
  @JsonKey(name: "published_content_count")
  int get publishedContentCount;
  @override
  @JsonKey(name: "last_published_content_datetime")
  DateTime get lastPublishedContentDatetime;
  @override
  @JsonKey(name: "latest_content_id")
  int get latestContentId;
  @override
  @JsonKey(name: "user")
  User get user;

  /// Create a copy of NovelSeries
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelSeriesImplCopyWith<_$NovelSeriesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "account")
  String get account => throw _privateConstructorUsedError;
  @JsonKey(name: "profile_image_urls")
  ProfileImageUrls get profileImageUrls => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "account") String account,
      @JsonKey(name: "profile_image_urls") ProfileImageUrls profileImageUrls});

  $ProfileImageUrlsCopyWith<$Res> get profileImageUrls;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? account = null,
    Object? profileImageUrls = null,
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
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrls: null == profileImageUrls
          ? _value.profileImageUrls
          : profileImageUrls // ignore: cast_nullable_to_non_nullable
              as ProfileImageUrls,
    ) as $Val);
  }

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProfileImageUrlsCopyWith<$Res> get profileImageUrls {
    return $ProfileImageUrlsCopyWith<$Res>(_value.profileImageUrls, (value) {
      return _then(_value.copyWith(profileImageUrls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "account") String account,
      @JsonKey(name: "profile_image_urls") ProfileImageUrls profileImageUrls});

  @override
  $ProfileImageUrlsCopyWith<$Res> get profileImageUrls;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? account = null,
    Object? profileImageUrls = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrls: null == profileImageUrls
          ? _value.profileImageUrls
          : profileImageUrls // ignore: cast_nullable_to_non_nullable
              as ProfileImageUrls,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {@JsonKey(name: "id") required this.id,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "account") required this.account,
      @JsonKey(name: "profile_image_urls") required this.profileImageUrls});

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  @JsonKey(name: "id")
  final int id;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "account")
  final String account;
  @override
  @JsonKey(name: "profile_image_urls")
  final ProfileImageUrls profileImageUrls;

  @override
  String toString() {
    return 'User(id: $id, name: $name, account: $account, profileImageUrls: $profileImageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.profileImageUrls, profileImageUrls) ||
                other.profileImageUrls == profileImageUrls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, account, profileImageUrls);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "name") required final String name,
      @JsonKey(name: "account") required final String account,
      @JsonKey(name: "profile_image_urls")
      required final ProfileImageUrls profileImageUrls}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  @JsonKey(name: "id")
  int get id;
  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "account")
  String get account;
  @override
  @JsonKey(name: "profile_image_urls")
  ProfileImageUrls get profileImageUrls;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
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
