// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_viewer_settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NovelViewerSettingsModel {
  double get textSize => throw _privateConstructorUsedError;

  /// 主题名称，空时为默认，'custom' 时为自定义
  String? get themeName => throw _privateConstructorUsedError;

  /// 自定义主题
  NovelViewerTheme? get customTheme => throw _privateConstructorUsedError;

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelViewerSettingsModelCopyWith<NovelViewerSettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelViewerSettingsModelCopyWith<$Res> {
  factory $NovelViewerSettingsModelCopyWith(NovelViewerSettingsModel value,
          $Res Function(NovelViewerSettingsModel) then) =
      _$NovelViewerSettingsModelCopyWithImpl<$Res, NovelViewerSettingsModel>;
  @useResult
  $Res call(
      {double textSize, String? themeName, NovelViewerTheme? customTheme});

  $NovelViewerThemeCopyWith<$Res>? get customTheme;
}

/// @nodoc
class _$NovelViewerSettingsModelCopyWithImpl<$Res,
        $Val extends NovelViewerSettingsModel>
    implements $NovelViewerSettingsModelCopyWith<$Res> {
  _$NovelViewerSettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textSize = null,
    Object? themeName = freezed,
    Object? customTheme = freezed,
  }) {
    return _then(_value.copyWith(
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      themeName: freezed == themeName
          ? _value.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as String?,
      customTheme: freezed == customTheme
          ? _value.customTheme
          : customTheme // ignore: cast_nullable_to_non_nullable
              as NovelViewerTheme?,
    ) as $Val);
  }

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NovelViewerThemeCopyWith<$Res>? get customTheme {
    if (_value.customTheme == null) {
      return null;
    }

    return $NovelViewerThemeCopyWith<$Res>(_value.customTheme!, (value) {
      return _then(_value.copyWith(customTheme: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NovelViewerSettingsModelImplCopyWith<$Res>
    implements $NovelViewerSettingsModelCopyWith<$Res> {
  factory _$$NovelViewerSettingsModelImplCopyWith(
          _$NovelViewerSettingsModelImpl value,
          $Res Function(_$NovelViewerSettingsModelImpl) then) =
      __$$NovelViewerSettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double textSize, String? themeName, NovelViewerTheme? customTheme});

  @override
  $NovelViewerThemeCopyWith<$Res>? get customTheme;
}

/// @nodoc
class __$$NovelViewerSettingsModelImplCopyWithImpl<$Res>
    extends _$NovelViewerSettingsModelCopyWithImpl<$Res,
        _$NovelViewerSettingsModelImpl>
    implements _$$NovelViewerSettingsModelImplCopyWith<$Res> {
  __$$NovelViewerSettingsModelImplCopyWithImpl(
      _$NovelViewerSettingsModelImpl _value,
      $Res Function(_$NovelViewerSettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textSize = null,
    Object? themeName = freezed,
    Object? customTheme = freezed,
  }) {
    return _then(_$NovelViewerSettingsModelImpl(
      textSize: null == textSize
          ? _value.textSize
          : textSize // ignore: cast_nullable_to_non_nullable
              as double,
      themeName: freezed == themeName
          ? _value.themeName
          : themeName // ignore: cast_nullable_to_non_nullable
              as String?,
      customTheme: freezed == customTheme
          ? _value.customTheme
          : customTheme // ignore: cast_nullable_to_non_nullable
              as NovelViewerTheme?,
    ));
  }
}

/// @nodoc

class _$NovelViewerSettingsModelImpl implements _NovelViewerSettingsModel {
  const _$NovelViewerSettingsModelImpl(
      {required this.textSize, this.themeName, this.customTheme});

  @override
  final double textSize;

  /// 主题名称，空时为默认，'custom' 时为自定义
  @override
  final String? themeName;

  /// 自定义主题
  @override
  final NovelViewerTheme? customTheme;

  @override
  String toString() {
    return 'NovelViewerSettingsModel(textSize: $textSize, themeName: $themeName, customTheme: $customTheme)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelViewerSettingsModelImpl &&
            (identical(other.textSize, textSize) ||
                other.textSize == textSize) &&
            (identical(other.themeName, themeName) ||
                other.themeName == themeName) &&
            (identical(other.customTheme, customTheme) ||
                other.customTheme == customTheme));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, textSize, themeName, customTheme);

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelViewerSettingsModelImplCopyWith<_$NovelViewerSettingsModelImpl>
      get copyWith => __$$NovelViewerSettingsModelImplCopyWithImpl<
          _$NovelViewerSettingsModelImpl>(this, _$identity);
}

abstract class _NovelViewerSettingsModel implements NovelViewerSettingsModel {
  const factory _NovelViewerSettingsModel(
      {required final double textSize,
      final String? themeName,
      final NovelViewerTheme? customTheme}) = _$NovelViewerSettingsModelImpl;

  @override
  double get textSize;

  /// 主题名称，空时为默认，'custom' 时为自定义
  @override
  String? get themeName;

  /// 自定义主题
  @override
  NovelViewerTheme? get customTheme;

  /// Create a copy of NovelViewerSettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelViewerSettingsModelImplCopyWith<_$NovelViewerSettingsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NovelViewerTheme _$NovelViewerThemeFromJson(Map<String, dynamic> json) {
  return _NovelViewerTheme.fromJson(json);
}

/// @nodoc
mixin _$NovelViewerTheme {
  int get foreground => throw _privateConstructorUsedError;
  int get background => throw _privateConstructorUsedError;

  /// Serializes this NovelViewerTheme to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NovelViewerTheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NovelViewerThemeCopyWith<NovelViewerTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelViewerThemeCopyWith<$Res> {
  factory $NovelViewerThemeCopyWith(
          NovelViewerTheme value, $Res Function(NovelViewerTheme) then) =
      _$NovelViewerThemeCopyWithImpl<$Res, NovelViewerTheme>;
  @useResult
  $Res call({int foreground, int background});
}

/// @nodoc
class _$NovelViewerThemeCopyWithImpl<$Res, $Val extends NovelViewerTheme>
    implements $NovelViewerThemeCopyWith<$Res> {
  _$NovelViewerThemeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NovelViewerTheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foreground = null,
    Object? background = null,
  }) {
    return _then(_value.copyWith(
      foreground: null == foreground
          ? _value.foreground
          : foreground // ignore: cast_nullable_to_non_nullable
              as int,
      background: null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NovelViewerThemeImplCopyWith<$Res>
    implements $NovelViewerThemeCopyWith<$Res> {
  factory _$$NovelViewerThemeImplCopyWith(_$NovelViewerThemeImpl value,
          $Res Function(_$NovelViewerThemeImpl) then) =
      __$$NovelViewerThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int foreground, int background});
}

/// @nodoc
class __$$NovelViewerThemeImplCopyWithImpl<$Res>
    extends _$NovelViewerThemeCopyWithImpl<$Res, _$NovelViewerThemeImpl>
    implements _$$NovelViewerThemeImplCopyWith<$Res> {
  __$$NovelViewerThemeImplCopyWithImpl(_$NovelViewerThemeImpl _value,
      $Res Function(_$NovelViewerThemeImpl) _then)
      : super(_value, _then);

  /// Create a copy of NovelViewerTheme
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foreground = null,
    Object? background = null,
  }) {
    return _then(_$NovelViewerThemeImpl(
      foreground: null == foreground
          ? _value.foreground
          : foreground // ignore: cast_nullable_to_non_nullable
              as int,
      background: null == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NovelViewerThemeImpl implements _NovelViewerTheme {
  const _$NovelViewerThemeImpl(
      {required this.foreground, required this.background});

  factory _$NovelViewerThemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$NovelViewerThemeImplFromJson(json);

  @override
  final int foreground;
  @override
  final int background;

  @override
  String toString() {
    return 'NovelViewerTheme(foreground: $foreground, background: $background)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NovelViewerThemeImpl &&
            (identical(other.foreground, foreground) ||
                other.foreground == foreground) &&
            (identical(other.background, background) ||
                other.background == background));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, foreground, background);

  /// Create a copy of NovelViewerTheme
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NovelViewerThemeImplCopyWith<_$NovelViewerThemeImpl> get copyWith =>
      __$$NovelViewerThemeImplCopyWithImpl<_$NovelViewerThemeImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NovelViewerThemeImplToJson(
      this,
    );
  }
}

abstract class _NovelViewerTheme implements NovelViewerTheme {
  const factory _NovelViewerTheme(
      {required final int foreground,
      required final int background}) = _$NovelViewerThemeImpl;

  factory _NovelViewerTheme.fromJson(Map<String, dynamic> json) =
      _$NovelViewerThemeImpl.fromJson;

  @override
  int get foreground;
  @override
  int get background;

  /// Create a copy of NovelViewerTheme
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NovelViewerThemeImplCopyWith<_$NovelViewerThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
