// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LanguageModel {
  /// MaterialApp locale，当 null 时为跟随系统
  Locale? get appLocale => throw _privateConstructorUsedError;

  /// 跟随系统回调的 Locale
  Locale get callbackLocale => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LanguageModelCopyWith<LanguageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageModelCopyWith<$Res> {
  factory $LanguageModelCopyWith(
          LanguageModel value, $Res Function(LanguageModel) then) =
      _$LanguageModelCopyWithImpl<$Res, LanguageModel>;
  @useResult
  $Res call({Locale? appLocale, Locale callbackLocale});
}

/// @nodoc
class _$LanguageModelCopyWithImpl<$Res, $Val extends LanguageModel>
    implements $LanguageModelCopyWith<$Res> {
  _$LanguageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appLocale = freezed,
    Object? callbackLocale = null,
  }) {
    return _then(_value.copyWith(
      appLocale: freezed == appLocale
          ? _value.appLocale
          : appLocale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      callbackLocale: null == callbackLocale
          ? _value.callbackLocale
          : callbackLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LanguageModelImplCopyWith<$Res>
    implements $LanguageModelCopyWith<$Res> {
  factory _$$LanguageModelImplCopyWith(
          _$LanguageModelImpl value, $Res Function(_$LanguageModelImpl) then) =
      __$$LanguageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Locale? appLocale, Locale callbackLocale});
}

/// @nodoc
class __$$LanguageModelImplCopyWithImpl<$Res>
    extends _$LanguageModelCopyWithImpl<$Res, _$LanguageModelImpl>
    implements _$$LanguageModelImplCopyWith<$Res> {
  __$$LanguageModelImplCopyWithImpl(
      _$LanguageModelImpl _value, $Res Function(_$LanguageModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appLocale = freezed,
    Object? callbackLocale = null,
  }) {
    return _then(_$LanguageModelImpl(
      appLocale: freezed == appLocale
          ? _value.appLocale
          : appLocale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      callbackLocale: null == callbackLocale
          ? _value.callbackLocale
          : callbackLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$LanguageModelImpl extends _LanguageModel {
  const _$LanguageModelImpl(
      {required this.appLocale, required this.callbackLocale})
      : super._();

  /// MaterialApp locale，当 null 时为跟随系统
  @override
  final Locale? appLocale;

  /// 跟随系统回调的 Locale
  @override
  final Locale callbackLocale;

  @override
  String toString() {
    return 'LanguageModel(appLocale: $appLocale, callbackLocale: $callbackLocale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageModelImpl &&
            (identical(other.appLocale, appLocale) ||
                other.appLocale == appLocale) &&
            (identical(other.callbackLocale, callbackLocale) ||
                other.callbackLocale == callbackLocale));
  }

  @override
  int get hashCode => Object.hash(runtimeType, appLocale, callbackLocale);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageModelImplCopyWith<_$LanguageModelImpl> get copyWith =>
      __$$LanguageModelImplCopyWithImpl<_$LanguageModelImpl>(this, _$identity);
}

abstract class _LanguageModel extends LanguageModel {
  const factory _LanguageModel(
      {required final Locale? appLocale,
      required final Locale callbackLocale}) = _$LanguageModelImpl;
  const _LanguageModel._() : super._();

  @override

  /// MaterialApp locale，当 null 时为跟随系统
  Locale? get appLocale;
  @override

  /// 跟随系统回调的 Locale
  Locale get callbackLocale;
  @override
  @JsonKey(ignore: true)
  _$$LanguageModelImplCopyWith<_$LanguageModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
