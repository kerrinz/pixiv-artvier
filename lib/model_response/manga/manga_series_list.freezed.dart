// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_series_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MangaSeriesListResponse _$MangaSeriesListResponseFromJson(
    Map<String, dynamic> json) {
  return _MangaSeriesListResponse.fromJson(json);
}

/// @nodoc
mixin _$MangaSeriesListResponse {
  @JsonKey(name: "series")
  List<MangaSeries> get series => throw _privateConstructorUsedError;
  @JsonKey(name: "next_url")
  String? get nextUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaSeriesListResponseCopyWith<MangaSeriesListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaSeriesListResponseCopyWith<$Res> {
  factory $MangaSeriesListResponseCopyWith(MangaSeriesListResponse value,
          $Res Function(MangaSeriesListResponse) then) =
      _$MangaSeriesListResponseCopyWithImpl<$Res, MangaSeriesListResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "series") List<MangaSeries> series,
      @JsonKey(name: "next_url") String? nextUrl});
}

/// @nodoc
class _$MangaSeriesListResponseCopyWithImpl<$Res,
        $Val extends MangaSeriesListResponse>
    implements $MangaSeriesListResponseCopyWith<$Res> {
  _$MangaSeriesListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
              as List<MangaSeries>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaSeriesListResponseImplCopyWith<$Res>
    implements $MangaSeriesListResponseCopyWith<$Res> {
  factory _$$MangaSeriesListResponseImplCopyWith(
          _$MangaSeriesListResponseImpl value,
          $Res Function(_$MangaSeriesListResponseImpl) then) =
      __$$MangaSeriesListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "series") List<MangaSeries> series,
      @JsonKey(name: "next_url") String? nextUrl});
}

/// @nodoc
class __$$MangaSeriesListResponseImplCopyWithImpl<$Res>
    extends _$MangaSeriesListResponseCopyWithImpl<$Res,
        _$MangaSeriesListResponseImpl>
    implements _$$MangaSeriesListResponseImplCopyWith<$Res> {
  __$$MangaSeriesListResponseImplCopyWithImpl(
      _$MangaSeriesListResponseImpl _value,
      $Res Function(_$MangaSeriesListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? series = null,
    Object? nextUrl = freezed,
  }) {
    return _then(_$MangaSeriesListResponseImpl(
      series: null == series
          ? _value._series
          : series // ignore: cast_nullable_to_non_nullable
              as List<MangaSeries>,
      nextUrl: freezed == nextUrl
          ? _value.nextUrl
          : nextUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaSeriesListResponseImpl implements _MangaSeriesListResponse {
  const _$MangaSeriesListResponseImpl(
      {@JsonKey(name: "series") required final List<MangaSeries> series,
      @JsonKey(name: "next_url") required this.nextUrl})
      : _series = series;

  factory _$MangaSeriesListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaSeriesListResponseImplFromJson(json);

  final List<MangaSeries> _series;
  @override
  @JsonKey(name: "series")
  List<MangaSeries> get series {
    if (_series is EqualUnmodifiableListView) return _series;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_series);
  }

  @override
  @JsonKey(name: "next_url")
  final String? nextUrl;

  @override
  String toString() {
    return 'MangaSeriesListResponse(series: $series, nextUrl: $nextUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaSeriesListResponseImpl &&
            const DeepCollectionEquality().equals(other._series, _series) &&
            (identical(other.nextUrl, nextUrl) || other.nextUrl == nextUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_series), nextUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaSeriesListResponseImplCopyWith<_$MangaSeriesListResponseImpl>
      get copyWith => __$$MangaSeriesListResponseImplCopyWithImpl<
          _$MangaSeriesListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaSeriesListResponseImplToJson(
      this,
    );
  }
}

abstract class _MangaSeriesListResponse implements MangaSeriesListResponse {
  const factory _MangaSeriesListResponse(
          {@JsonKey(name: "series") required final List<MangaSeries> series,
          @JsonKey(name: "next_url") required final String? nextUrl}) =
      _$MangaSeriesListResponseImpl;

  factory _MangaSeriesListResponse.fromJson(Map<String, dynamic> json) =
      _$MangaSeriesListResponseImpl.fromJson;

  @override
  @JsonKey(name: "series")
  List<MangaSeries> get series;
  @override
  @JsonKey(name: "next_url")
  String? get nextUrl;
  @override
  @JsonKey(ignore: true)
  _$$MangaSeriesListResponseImplCopyWith<_$MangaSeriesListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MangaSeries _$MangaSeriesFromJson(Map<String, dynamic> json) {
  return _MangaSeries.fromJson(json);
}

/// @nodoc
mixin _$MangaSeries {
  @JsonKey(name: "id")
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: "title")
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: "url")
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: "mask_text")
  String? get maskText => throw _privateConstructorUsedError;
  @JsonKey(name: "published_content_count")
  int get publishedContentCount => throw _privateConstructorUsedError;
  @JsonKey(name: "last_published_content_datetime")
  DateTime get lastPublishedContentDatetime =>
      throw _privateConstructorUsedError;
  @JsonKey(name: "latest_content_id")
  int get latestContentId => throw _privateConstructorUsedError;
  @JsonKey(name: "user")
  User get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaSeriesCopyWith<MangaSeries> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaSeriesCopyWith<$Res> {
  factory $MangaSeriesCopyWith(
          MangaSeries value, $Res Function(MangaSeries) then) =
      _$MangaSeriesCopyWithImpl<$Res, MangaSeries>;
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "url") String url,
      @JsonKey(name: "mask_text") String? maskText,
      @JsonKey(name: "published_content_count") int publishedContentCount,
      @JsonKey(name: "last_published_content_datetime")
      DateTime lastPublishedContentDatetime,
      @JsonKey(name: "latest_content_id") int latestContentId,
      @JsonKey(name: "user") User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$MangaSeriesCopyWithImpl<$Res, $Val extends MangaSeries>
    implements $MangaSeriesCopyWith<$Res> {
  _$MangaSeriesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
              as String?,
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

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MangaSeriesImplCopyWith<$Res>
    implements $MangaSeriesCopyWith<$Res> {
  factory _$$MangaSeriesImplCopyWith(
          _$MangaSeriesImpl value, $Res Function(_$MangaSeriesImpl) then) =
      __$$MangaSeriesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "id") int id,
      @JsonKey(name: "title") String title,
      @JsonKey(name: "url") String url,
      @JsonKey(name: "mask_text") String? maskText,
      @JsonKey(name: "published_content_count") int publishedContentCount,
      @JsonKey(name: "last_published_content_datetime")
      DateTime lastPublishedContentDatetime,
      @JsonKey(name: "latest_content_id") int latestContentId,
      @JsonKey(name: "user") User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$MangaSeriesImplCopyWithImpl<$Res>
    extends _$MangaSeriesCopyWithImpl<$Res, _$MangaSeriesImpl>
    implements _$$MangaSeriesImplCopyWith<$Res> {
  __$$MangaSeriesImplCopyWithImpl(
      _$MangaSeriesImpl _value, $Res Function(_$MangaSeriesImpl) _then)
      : super(_value, _then);

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
    return _then(_$MangaSeriesImpl(
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
              as String?,
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
class _$MangaSeriesImpl implements _MangaSeries {
  const _$MangaSeriesImpl(
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

  factory _$MangaSeriesImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaSeriesImplFromJson(json);

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
  final String? maskText;
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
    return 'MangaSeries(id: $id, title: $title, url: $url, maskText: $maskText, publishedContentCount: $publishedContentCount, lastPublishedContentDatetime: $lastPublishedContentDatetime, latestContentId: $latestContentId, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaSeriesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.maskText, maskText) ||
                other.maskText == maskText) &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      url,
      maskText,
      publishedContentCount,
      lastPublishedContentDatetime,
      latestContentId,
      user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaSeriesImplCopyWith<_$MangaSeriesImpl> get copyWith =>
      __$$MangaSeriesImplCopyWithImpl<_$MangaSeriesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaSeriesImplToJson(
      this,
    );
  }
}

abstract class _MangaSeries implements MangaSeries {
  const factory _MangaSeries(
      {@JsonKey(name: "id") required final int id,
      @JsonKey(name: "title") required final String title,
      @JsonKey(name: "url") required final String url,
      @JsonKey(name: "mask_text") required final String? maskText,
      @JsonKey(name: "published_content_count")
      required final int publishedContentCount,
      @JsonKey(name: "last_published_content_datetime")
      required final DateTime lastPublishedContentDatetime,
      @JsonKey(name: "latest_content_id") required final int latestContentId,
      @JsonKey(name: "user") required final User user}) = _$MangaSeriesImpl;

  factory _MangaSeries.fromJson(Map<String, dynamic> json) =
      _$MangaSeriesImpl.fromJson;

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
  String? get maskText;
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
  @override
  @JsonKey(ignore: true)
  _$$MangaSeriesImplCopyWith<_$MangaSeriesImpl> get copyWith =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, account, profileImageUrls);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, medium);

  @JsonKey(ignore: true)
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
  @override
  @JsonKey(ignore: true)
  _$$ProfileImageUrlsImplCopyWith<_$ProfileImageUrlsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
