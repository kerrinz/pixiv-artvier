// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'works_badge_argument.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WorksBadgeArgument {
  String get text => throw _privateConstructorUsedError;
  Color? get textColor => throw _privateConstructorUsedError;
  Color? get backgroundColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WorksBadgeArgumentCopyWith<WorksBadgeArgument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorksBadgeArgumentCopyWith<$Res> {
  factory $WorksBadgeArgumentCopyWith(
          WorksBadgeArgument value, $Res Function(WorksBadgeArgument) then) =
      _$WorksBadgeArgumentCopyWithImpl<$Res, WorksBadgeArgument>;
  @useResult
  $Res call({String text, Color? textColor, Color? backgroundColor});
}

/// @nodoc
class _$WorksBadgeArgumentCopyWithImpl<$Res, $Val extends WorksBadgeArgument>
    implements $WorksBadgeArgumentCopyWith<$Res> {
  _$WorksBadgeArgumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? textColor = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      textColor: freezed == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorksBadgeArgumentImplCopyWith<$Res>
    implements $WorksBadgeArgumentCopyWith<$Res> {
  factory _$$WorksBadgeArgumentImplCopyWith(_$WorksBadgeArgumentImpl value,
          $Res Function(_$WorksBadgeArgumentImpl) then) =
      __$$WorksBadgeArgumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, Color? textColor, Color? backgroundColor});
}

/// @nodoc
class __$$WorksBadgeArgumentImplCopyWithImpl<$Res>
    extends _$WorksBadgeArgumentCopyWithImpl<$Res, _$WorksBadgeArgumentImpl>
    implements _$$WorksBadgeArgumentImplCopyWith<$Res> {
  __$$WorksBadgeArgumentImplCopyWithImpl(_$WorksBadgeArgumentImpl _value,
      $Res Function(_$WorksBadgeArgumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? textColor = freezed,
    Object? backgroundColor = freezed,
  }) {
    return _then(_$WorksBadgeArgumentImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      textColor: freezed == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      backgroundColor: freezed == backgroundColor
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// @nodoc

class _$WorksBadgeArgumentImpl implements _WorksBadgeArgument {
  const _$WorksBadgeArgumentImpl(
      {required this.text, this.textColor, this.backgroundColor});

  @override
  final String text;
  @override
  final Color? textColor;
  @override
  final Color? backgroundColor;

  @override
  String toString() {
    return 'WorksBadgeArgument(text: $text, textColor: $textColor, backgroundColor: $backgroundColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorksBadgeArgumentImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, text, textColor, backgroundColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WorksBadgeArgumentImplCopyWith<_$WorksBadgeArgumentImpl> get copyWith =>
      __$$WorksBadgeArgumentImplCopyWithImpl<_$WorksBadgeArgumentImpl>(
          this, _$identity);
}

abstract class _WorksBadgeArgument implements WorksBadgeArgument {
  const factory _WorksBadgeArgument(
      {required final String text,
      final Color? textColor,
      final Color? backgroundColor}) = _$WorksBadgeArgumentImpl;

  @override
  String get text;
  @override
  Color? get textColor;
  @override
  Color? get backgroundColor;
  @override
  @JsonKey(ignore: true)
  _$$WorksBadgeArgumentImplCopyWith<_$WorksBadgeArgumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
