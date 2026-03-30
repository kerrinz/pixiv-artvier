// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resource_load_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ResourceLoadSettingsModel {
  /// 列表画质
  ListPreviewQuality get listPreviewQuality =>
      throw _privateConstructorUsedError;

  /// 插画详情页画质
  DetailsPageQuality get illustDetailsQuality =>
      throw _privateConstructorUsedError;

  /// 漫画详情页画质
  DetailsPageQuality get mangaDetailsQuality =>
      throw _privateConstructorUsedError;

  /// Create a copy of ResourceLoadSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResourceLoadSettingsModelCopyWith<ResourceLoadSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResourceLoadSettingsModelCopyWith<$Res> {
  factory $ResourceLoadSettingsModelCopyWith(ResourceLoadSettingsModel value,
          $Res Function(ResourceLoadSettingsModel) then) =
      _$ResourceLoadSettingsModelCopyWithImpl<$Res, ResourceLoadSettingsModel>;
  @useResult
  $Res call(
      {ListPreviewQuality listPreviewQuality,
      DetailsPageQuality illustDetailsQuality,
      DetailsPageQuality mangaDetailsQuality});
}

/// @nodoc
class _$ResourceLoadSettingsModelCopyWithImpl<$Res,
        $Val extends ResourceLoadSettingsModel>
    implements $ResourceLoadSettingsModelCopyWith<$Res> {
  _$ResourceLoadSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResourceLoadSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listPreviewQuality = null,
    Object? illustDetailsQuality = null,
    Object? mangaDetailsQuality = null,
  }) {
    return _then(_value.copyWith(
      listPreviewQuality: null == listPreviewQuality
          ? _value.listPreviewQuality
          : listPreviewQuality // ignore: cast_nullable_to_non_nullable
              as ListPreviewQuality,
      illustDetailsQuality: null == illustDetailsQuality
          ? _value.illustDetailsQuality
          : illustDetailsQuality // ignore: cast_nullable_to_non_nullable
              as DetailsPageQuality,
      mangaDetailsQuality: null == mangaDetailsQuality
          ? _value.mangaDetailsQuality
          : mangaDetailsQuality // ignore: cast_nullable_to_non_nullable
              as DetailsPageQuality,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResourceLoadSettingsModelImplCopyWith<$Res>
    implements $ResourceLoadSettingsModelCopyWith<$Res> {
  factory _$$ResourceLoadSettingsModelImplCopyWith(
          _$ResourceLoadSettingsModelImpl value,
          $Res Function(_$ResourceLoadSettingsModelImpl) then) =
      __$$ResourceLoadSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ListPreviewQuality listPreviewQuality,
      DetailsPageQuality illustDetailsQuality,
      DetailsPageQuality mangaDetailsQuality});
}

/// @nodoc
class __$$ResourceLoadSettingsModelImplCopyWithImpl<$Res>
    extends _$ResourceLoadSettingsModelCopyWithImpl<$Res,
        _$ResourceLoadSettingsModelImpl>
    implements _$$ResourceLoadSettingsModelImplCopyWith<$Res> {
  __$$ResourceLoadSettingsModelImplCopyWithImpl(
      _$ResourceLoadSettingsModelImpl _value,
      $Res Function(_$ResourceLoadSettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ResourceLoadSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listPreviewQuality = null,
    Object? illustDetailsQuality = null,
    Object? mangaDetailsQuality = null,
  }) {
    return _then(_$ResourceLoadSettingsModelImpl(
      listPreviewQuality: null == listPreviewQuality
          ? _value.listPreviewQuality
          : listPreviewQuality // ignore: cast_nullable_to_non_nullable
              as ListPreviewQuality,
      illustDetailsQuality: null == illustDetailsQuality
          ? _value.illustDetailsQuality
          : illustDetailsQuality // ignore: cast_nullable_to_non_nullable
              as DetailsPageQuality,
      mangaDetailsQuality: null == mangaDetailsQuality
          ? _value.mangaDetailsQuality
          : mangaDetailsQuality // ignore: cast_nullable_to_non_nullable
              as DetailsPageQuality,
    ));
  }
}

/// @nodoc

class _$ResourceLoadSettingsModelImpl implements _ResourceLoadSettingsModel {
  const _$ResourceLoadSettingsModelImpl(
      {required this.listPreviewQuality,
      required this.illustDetailsQuality,
      required this.mangaDetailsQuality});

  /// 列表画质
  @override
  final ListPreviewQuality listPreviewQuality;

  /// 插画详情页画质
  @override
  final DetailsPageQuality illustDetailsQuality;

  /// 漫画详情页画质
  @override
  final DetailsPageQuality mangaDetailsQuality;

  @override
  String toString() {
    return 'ResourceLoadSettingsModel(listPreviewQuality: $listPreviewQuality, illustDetailsQuality: $illustDetailsQuality, mangaDetailsQuality: $mangaDetailsQuality)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResourceLoadSettingsModelImpl &&
            (identical(other.listPreviewQuality, listPreviewQuality) ||
                other.listPreviewQuality == listPreviewQuality) &&
            (identical(other.illustDetailsQuality, illustDetailsQuality) ||
                other.illustDetailsQuality == illustDetailsQuality) &&
            (identical(other.mangaDetailsQuality, mangaDetailsQuality) ||
                other.mangaDetailsQuality == mangaDetailsQuality));
  }

  @override
  int get hashCode => Object.hash(runtimeType, listPreviewQuality,
      illustDetailsQuality, mangaDetailsQuality);

  /// Create a copy of ResourceLoadSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResourceLoadSettingsModelImplCopyWith<_$ResourceLoadSettingsModelImpl>
      get copyWith => __$$ResourceLoadSettingsModelImplCopyWithImpl<
          _$ResourceLoadSettingsModelImpl>(this, _$identity);
}

abstract class _ResourceLoadSettingsModel implements ResourceLoadSettingsModel {
  const factory _ResourceLoadSettingsModel(
          {required final ListPreviewQuality listPreviewQuality,
          required final DetailsPageQuality illustDetailsQuality,
          required final DetailsPageQuality mangaDetailsQuality}) =
      _$ResourceLoadSettingsModelImpl;

  /// 列表画质
  @override
  ListPreviewQuality get listPreviewQuality;

  /// 插画详情页画质
  @override
  DetailsPageQuality get illustDetailsQuality;

  /// 漫画详情页画质
  @override
  DetailsPageQuality get mangaDetailsQuality;

  /// Create a copy of ResourceLoadSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResourceLoadSettingsModelImplCopyWith<_$ResourceLoadSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
