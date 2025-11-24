// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_tag.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommonTag _$CommonTagFromJson(Map<String, dynamic> json) {
  return _CommonTag.fromJson(json);
}

/// @nodoc
mixin _$CommonTag {
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "translated_name")
  String? get translatedName => throw _privateConstructorUsedError;

  /// Serializes this CommonTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommonTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommonTagCopyWith<CommonTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommonTagCopyWith<$Res> {
  factory $CommonTagCopyWith(CommonTag value, $Res Function(CommonTag) then) =
      _$CommonTagCopyWithImpl<$Res, CommonTag>;
  @useResult
  $Res call(
      {@JsonKey(name: "name") String name,
      @JsonKey(name: "translated_name") String? translatedName});
}

/// @nodoc
class _$CommonTagCopyWithImpl<$Res, $Val extends CommonTag>
    implements $CommonTagCopyWith<$Res> {
  _$CommonTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommonTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? translatedName = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      translatedName: freezed == translatedName
          ? _value.translatedName
          : translatedName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommonTagImplCopyWith<$Res>
    implements $CommonTagCopyWith<$Res> {
  factory _$$CommonTagImplCopyWith(
          _$CommonTagImpl value, $Res Function(_$CommonTagImpl) then) =
      __$$CommonTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "name") String name,
      @JsonKey(name: "translated_name") String? translatedName});
}

/// @nodoc
class __$$CommonTagImplCopyWithImpl<$Res>
    extends _$CommonTagCopyWithImpl<$Res, _$CommonTagImpl>
    implements _$$CommonTagImplCopyWith<$Res> {
  __$$CommonTagImplCopyWithImpl(
      _$CommonTagImpl _value, $Res Function(_$CommonTagImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommonTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? translatedName = freezed,
  }) {
    return _then(_$CommonTagImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      translatedName: freezed == translatedName
          ? _value.translatedName
          : translatedName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommonTagImpl implements _CommonTag {
  const _$CommonTagImpl(
      {@JsonKey(name: "name") required this.name,
      @JsonKey(name: "translated_name") this.translatedName});

  factory _$CommonTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommonTagImplFromJson(json);

  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "translated_name")
  final String? translatedName;

  @override
  String toString() {
    return 'CommonTag(name: $name, translatedName: $translatedName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommonTagImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.translatedName, translatedName) ||
                other.translatedName == translatedName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, translatedName);

  /// Create a copy of CommonTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommonTagImplCopyWith<_$CommonTagImpl> get copyWith =>
      __$$CommonTagImplCopyWithImpl<_$CommonTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommonTagImplToJson(
      this,
    );
  }
}

abstract class _CommonTag implements CommonTag {
  const factory _CommonTag(
          {@JsonKey(name: "name") required final String name,
          @JsonKey(name: "translated_name") final String? translatedName}) =
      _$CommonTagImpl;

  factory _CommonTag.fromJson(Map<String, dynamic> json) =
      _$CommonTagImpl.fromJson;

  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "translated_name")
  String? get translatedName;

  /// Create a copy of CommonTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommonTagImplCopyWith<_$CommonTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
