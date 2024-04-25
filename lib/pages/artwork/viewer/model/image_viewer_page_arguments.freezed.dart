// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_viewer_page_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ImageViewerPageArguments {
  /// 图片列表
  List<ImageQualityUrl> get urlList => throw _privateConstructorUsedError;

  /// 资源类型
  DownloadType get downloadType => throw _privateConstructorUsedError;

  /// 作品 id
  String get worksId => throw _privateConstructorUsedError;

  /// 作品标题
  String get title => throw _privateConstructorUsedError;

  /// 初始查看第几张图片
  int get index => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ImageViewerPageArgumentsCopyWith<ImageViewerPageArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageViewerPageArgumentsCopyWith<$Res> {
  factory $ImageViewerPageArgumentsCopyWith(ImageViewerPageArguments value,
          $Res Function(ImageViewerPageArguments) then) =
      _$ImageViewerPageArgumentsCopyWithImpl<$Res, ImageViewerPageArguments>;
  @useResult
  $Res call(
      {List<ImageQualityUrl> urlList,
      DownloadType downloadType,
      String worksId,
      String title,
      int index});
}

/// @nodoc
class _$ImageViewerPageArgumentsCopyWithImpl<$Res,
        $Val extends ImageViewerPageArguments>
    implements $ImageViewerPageArgumentsCopyWith<$Res> {
  _$ImageViewerPageArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urlList = null,
    Object? downloadType = null,
    Object? worksId = null,
    Object? title = null,
    Object? index = null,
  }) {
    return _then(_value.copyWith(
      urlList: null == urlList
          ? _value.urlList
          : urlList // ignore: cast_nullable_to_non_nullable
              as List<ImageQualityUrl>,
      downloadType: null == downloadType
          ? _value.downloadType
          : downloadType // ignore: cast_nullable_to_non_nullable
              as DownloadType,
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageViewerPageArgumentsImplCopyWith<$Res>
    implements $ImageViewerPageArgumentsCopyWith<$Res> {
  factory _$$ImageViewerPageArgumentsImplCopyWith(
          _$ImageViewerPageArgumentsImpl value,
          $Res Function(_$ImageViewerPageArgumentsImpl) then) =
      __$$ImageViewerPageArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ImageQualityUrl> urlList,
      DownloadType downloadType,
      String worksId,
      String title,
      int index});
}

/// @nodoc
class __$$ImageViewerPageArgumentsImplCopyWithImpl<$Res>
    extends _$ImageViewerPageArgumentsCopyWithImpl<$Res,
        _$ImageViewerPageArgumentsImpl>
    implements _$$ImageViewerPageArgumentsImplCopyWith<$Res> {
  __$$ImageViewerPageArgumentsImplCopyWithImpl(
      _$ImageViewerPageArgumentsImpl _value,
      $Res Function(_$ImageViewerPageArgumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? urlList = null,
    Object? downloadType = null,
    Object? worksId = null,
    Object? title = null,
    Object? index = null,
  }) {
    return _then(_$ImageViewerPageArgumentsImpl(
      urlList: null == urlList
          ? _value._urlList
          : urlList // ignore: cast_nullable_to_non_nullable
              as List<ImageQualityUrl>,
      downloadType: null == downloadType
          ? _value.downloadType
          : downloadType // ignore: cast_nullable_to_non_nullable
              as DownloadType,
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$ImageViewerPageArgumentsImpl implements _ImageViewerPageArguments {
  const _$ImageViewerPageArgumentsImpl(
      {required final List<ImageQualityUrl> urlList,
      required this.downloadType,
      required this.worksId,
      required this.title,
      required this.index})
      : _urlList = urlList;

  /// 图片列表
  final List<ImageQualityUrl> _urlList;

  /// 图片列表
  @override
  List<ImageQualityUrl> get urlList {
    if (_urlList is EqualUnmodifiableListView) return _urlList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urlList);
  }

  /// 资源类型
  @override
  final DownloadType downloadType;

  /// 作品 id
  @override
  final String worksId;

  /// 作品标题
  @override
  final String title;

  /// 初始查看第几张图片
  @override
  final int index;

  @override
  String toString() {
    return 'ImageViewerPageArguments(urlList: $urlList, downloadType: $downloadType, worksId: $worksId, title: $title, index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageViewerPageArgumentsImpl &&
            const DeepCollectionEquality().equals(other._urlList, _urlList) &&
            (identical(other.downloadType, downloadType) ||
                other.downloadType == downloadType) &&
            (identical(other.worksId, worksId) || other.worksId == worksId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_urlList),
      downloadType,
      worksId,
      title,
      index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageViewerPageArgumentsImplCopyWith<_$ImageViewerPageArgumentsImpl>
      get copyWith => __$$ImageViewerPageArgumentsImplCopyWithImpl<
          _$ImageViewerPageArgumentsImpl>(this, _$identity);
}

abstract class _ImageViewerPageArguments implements ImageViewerPageArguments {
  const factory _ImageViewerPageArguments(
      {required final List<ImageQualityUrl> urlList,
      required final DownloadType downloadType,
      required final String worksId,
      required final String title,
      required final int index}) = _$ImageViewerPageArgumentsImpl;

  @override

  /// 图片列表
  List<ImageQualityUrl> get urlList;
  @override

  /// 资源类型
  DownloadType get downloadType;
  @override

  /// 作品 id
  String get worksId;
  @override

  /// 作品标题
  String get title;
  @override

  /// 初始查看第几张图片
  int get index;
  @override
  @JsonKey(ignore: true)
  _$$ImageViewerPageArgumentsImplCopyWith<_$ImageViewerPageArgumentsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
