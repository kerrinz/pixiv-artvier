// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_download_task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageDownloadTaskModel _$ImageDownloadTaskModelFromJson(
    Map<String, dynamic> json) {
  return _ImageDownloadTaskModel.fromJson(json);
}

/// @nodoc
mixin _$ImageDownloadTaskModel {
  /// 所属作品的ID
  String get worksId => throw _privateConstructorUsedError;

  /// 图片在作品中的索引，eg: p0, p1 p2 p3
  int get pIndex => throw _privateConstructorUsedError;

  /// 参阅[DownloadStorage.downloadStateMap]
  int get downloadState => throw _privateConstructorUsedError;

  /// 已下载进度（字节）
  double? get receivedBytes => throw _privateConstructorUsedError;

  /// 图片总大小（字节）
  double? get totalBytes => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageDownloadTaskModelCopyWith<ImageDownloadTaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageDownloadTaskModelCopyWith<$Res> {
  factory $ImageDownloadTaskModelCopyWith(ImageDownloadTaskModel value,
          $Res Function(ImageDownloadTaskModel) then) =
      _$ImageDownloadTaskModelCopyWithImpl<$Res, ImageDownloadTaskModel>;
  @useResult
  $Res call(
      {String worksId,
      int pIndex,
      int downloadState,
      double? receivedBytes,
      double? totalBytes,
      String url,
      String title});
}

/// @nodoc
class _$ImageDownloadTaskModelCopyWithImpl<$Res,
        $Val extends ImageDownloadTaskModel>
    implements $ImageDownloadTaskModelCopyWith<$Res> {
  _$ImageDownloadTaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worksId = null,
    Object? pIndex = null,
    Object? downloadState = null,
    Object? receivedBytes = freezed,
    Object? totalBytes = freezed,
    Object? url = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      pIndex: null == pIndex
          ? _value.pIndex
          : pIndex // ignore: cast_nullable_to_non_nullable
              as int,
      downloadState: null == downloadState
          ? _value.downloadState
          : downloadState // ignore: cast_nullable_to_non_nullable
              as int,
      receivedBytes: freezed == receivedBytes
          ? _value.receivedBytes
          : receivedBytes // ignore: cast_nullable_to_non_nullable
              as double?,
      totalBytes: freezed == totalBytes
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as double?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageDownloadTaskModelImplCopyWith<$Res>
    implements $ImageDownloadTaskModelCopyWith<$Res> {
  factory _$$ImageDownloadTaskModelImplCopyWith(
          _$ImageDownloadTaskModelImpl value,
          $Res Function(_$ImageDownloadTaskModelImpl) then) =
      __$$ImageDownloadTaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String worksId,
      int pIndex,
      int downloadState,
      double? receivedBytes,
      double? totalBytes,
      String url,
      String title});
}

/// @nodoc
class __$$ImageDownloadTaskModelImplCopyWithImpl<$Res>
    extends _$ImageDownloadTaskModelCopyWithImpl<$Res,
        _$ImageDownloadTaskModelImpl>
    implements _$$ImageDownloadTaskModelImplCopyWith<$Res> {
  __$$ImageDownloadTaskModelImplCopyWithImpl(
      _$ImageDownloadTaskModelImpl _value,
      $Res Function(_$ImageDownloadTaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? worksId = null,
    Object? pIndex = null,
    Object? downloadState = null,
    Object? receivedBytes = freezed,
    Object? totalBytes = freezed,
    Object? url = null,
    Object? title = null,
  }) {
    return _then(_$ImageDownloadTaskModelImpl(
      worksId: null == worksId
          ? _value.worksId
          : worksId // ignore: cast_nullable_to_non_nullable
              as String,
      pIndex: null == pIndex
          ? _value.pIndex
          : pIndex // ignore: cast_nullable_to_non_nullable
              as int,
      downloadState: null == downloadState
          ? _value.downloadState
          : downloadState // ignore: cast_nullable_to_non_nullable
              as int,
      receivedBytes: freezed == receivedBytes
          ? _value.receivedBytes
          : receivedBytes // ignore: cast_nullable_to_non_nullable
              as double?,
      totalBytes: freezed == totalBytes
          ? _value.totalBytes
          : totalBytes // ignore: cast_nullable_to_non_nullable
              as double?,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageDownloadTaskModelImpl implements _ImageDownloadTaskModel {
  const _$ImageDownloadTaskModelImpl(
      {required this.worksId,
      required this.pIndex,
      required this.downloadState,
      this.receivedBytes,
      this.totalBytes,
      required this.url,
      required this.title});

  factory _$ImageDownloadTaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageDownloadTaskModelImplFromJson(json);

  /// 所属作品的ID
  @override
  final String worksId;

  /// 图片在作品中的索引，eg: p0, p1 p2 p3
  @override
  final int pIndex;

  /// 参阅[DownloadStorage.downloadStateMap]
  @override
  final int downloadState;

  /// 已下载进度（字节）
  @override
  final double? receivedBytes;

  /// 图片总大小（字节）
  @override
  final double? totalBytes;
  @override
  final String url;
  @override
  final String title;

  @override
  String toString() {
    return 'ImageDownloadTaskModel(worksId: $worksId, pIndex: $pIndex, downloadState: $downloadState, receivedBytes: $receivedBytes, totalBytes: $totalBytes, url: $url, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ImageDownloadTaskModelImpl &&
            (identical(other.worksId, worksId) || other.worksId == worksId) &&
            (identical(other.pIndex, pIndex) || other.pIndex == pIndex) &&
            (identical(other.downloadState, downloadState) ||
                other.downloadState == downloadState) &&
            (identical(other.receivedBytes, receivedBytes) ||
                other.receivedBytes == receivedBytes) &&
            (identical(other.totalBytes, totalBytes) ||
                other.totalBytes == totalBytes) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, worksId, pIndex, downloadState,
      receivedBytes, totalBytes, url, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageDownloadTaskModelImplCopyWith<_$ImageDownloadTaskModelImpl>
      get copyWith => __$$ImageDownloadTaskModelImplCopyWithImpl<
          _$ImageDownloadTaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageDownloadTaskModelImplToJson(
      this,
    );
  }
}

abstract class _ImageDownloadTaskModel implements ImageDownloadTaskModel {
  const factory _ImageDownloadTaskModel(
      {required final String worksId,
      required final int pIndex,
      required final int downloadState,
      final double? receivedBytes,
      final double? totalBytes,
      required final String url,
      required final String title}) = _$ImageDownloadTaskModelImpl;

  factory _ImageDownloadTaskModel.fromJson(Map<String, dynamic> json) =
      _$ImageDownloadTaskModelImpl.fromJson;

  @override

  /// 所属作品的ID
  String get worksId;
  @override

  /// 图片在作品中的索引，eg: p0, p1 p2 p3
  int get pIndex;
  @override

  /// 参阅[DownloadStorage.downloadStateMap]
  int get downloadState;
  @override

  /// 已下载进度（字节）
  double? get receivedBytes;
  @override

  /// 图片总大小（字节）
  double? get totalBytes;
  @override
  String get url;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$$ImageDownloadTaskModelImplCopyWith<_$ImageDownloadTaskModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
