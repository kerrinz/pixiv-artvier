// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MangaSeriesDetailPagePageArguments {
  /// ID
  int get id => throw _privateConstructorUsedError;

  /// 作品标题
  String get title => throw _privateConstructorUsedError;

  /// 封面图
  String get url => throw _privateConstructorUsedError;

  /// 作者
  User get user => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MangaSeriesDetailPagePageArgumentsCopyWith<
          MangaSeriesDetailPagePageArguments>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaSeriesDetailPagePageArgumentsCopyWith<$Res> {
  factory $MangaSeriesDetailPagePageArgumentsCopyWith(
          MangaSeriesDetailPagePageArguments value,
          $Res Function(MangaSeriesDetailPagePageArguments) then) =
      _$MangaSeriesDetailPagePageArgumentsCopyWithImpl<$Res,
          MangaSeriesDetailPagePageArguments>;
  @useResult
  $Res call({int id, String title, String url, User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$MangaSeriesDetailPagePageArgumentsCopyWithImpl<$Res,
        $Val extends MangaSeriesDetailPagePageArguments>
    implements $MangaSeriesDetailPagePageArgumentsCopyWith<$Res> {
  _$MangaSeriesDetailPagePageArgumentsCopyWithImpl(this._value, this._then);

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
abstract class _$$MangaSeriesDetailPagePageArgumentsImplCopyWith<$Res>
    implements $MangaSeriesDetailPagePageArgumentsCopyWith<$Res> {
  factory _$$MangaSeriesDetailPagePageArgumentsImplCopyWith(
          _$MangaSeriesDetailPagePageArgumentsImpl value,
          $Res Function(_$MangaSeriesDetailPagePageArgumentsImpl) then) =
      __$$MangaSeriesDetailPagePageArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String title, String url, User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$MangaSeriesDetailPagePageArgumentsImplCopyWithImpl<$Res>
    extends _$MangaSeriesDetailPagePageArgumentsCopyWithImpl<$Res,
        _$MangaSeriesDetailPagePageArgumentsImpl>
    implements _$$MangaSeriesDetailPagePageArgumentsImplCopyWith<$Res> {
  __$$MangaSeriesDetailPagePageArgumentsImplCopyWithImpl(
      _$MangaSeriesDetailPagePageArgumentsImpl _value,
      $Res Function(_$MangaSeriesDetailPagePageArgumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? user = null,
  }) {
    return _then(_$MangaSeriesDetailPagePageArgumentsImpl(
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
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc

class _$MangaSeriesDetailPagePageArgumentsImpl
    implements _MangaSeriesDetailPagePageArguments {
  const _$MangaSeriesDetailPagePageArgumentsImpl(
      {required this.id,
      required this.title,
      required this.url,
      required this.user});

  /// ID
  @override
  final int id;

  /// 作品标题
  @override
  final String title;

  /// 封面图
  @override
  final String url;

  /// 作者
  @override
  final User user;

  @override
  String toString() {
    return 'MangaSeriesDetailPagePageArguments(id: $id, title: $title, url: $url, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaSeriesDetailPagePageArgumentsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.user, user) || other.user == user));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaSeriesDetailPagePageArgumentsImplCopyWith<
          _$MangaSeriesDetailPagePageArgumentsImpl>
      get copyWith => __$$MangaSeriesDetailPagePageArgumentsImplCopyWithImpl<
          _$MangaSeriesDetailPagePageArgumentsImpl>(this, _$identity);
}

abstract class _MangaSeriesDetailPagePageArguments
    implements MangaSeriesDetailPagePageArguments {
  const factory _MangaSeriesDetailPagePageArguments(
      {required final int id,
      required final String title,
      required final String url,
      required final User user}) = _$MangaSeriesDetailPagePageArgumentsImpl;

  @override

  /// ID
  int get id;
  @override

  /// 作品标题
  String get title;
  @override

  /// 封面图
  String get url;
  @override

  /// 作者
  User get user;
  @override
  @JsonKey(ignore: true)
  _$$MangaSeriesDetailPagePageArgumentsImplCopyWith<
          _$MangaSeriesDetailPagePageArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
