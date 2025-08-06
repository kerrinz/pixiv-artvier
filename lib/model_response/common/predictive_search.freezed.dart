// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'predictive_search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PredictiveSearchWorks _$PredictiveSearchWorksFromJson(
    Map<String, dynamic> json) {
  return _PredictiveSearchWorks.fromJson(json);
}

/// @nodoc
mixin _$PredictiveSearchWorks {
  @JsonKey(name: "tags")
  List<PredictiveSearchWorksTag> get tags => throw _privateConstructorUsedError;

  /// Serializes this PredictiveSearchWorks to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PredictiveSearchWorks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictiveSearchWorksCopyWith<PredictiveSearchWorks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictiveSearchWorksCopyWith<$Res> {
  factory $PredictiveSearchWorksCopyWith(PredictiveSearchWorks value,
          $Res Function(PredictiveSearchWorks) then) =
      _$PredictiveSearchWorksCopyWithImpl<$Res, PredictiveSearchWorks>;
  @useResult
  $Res call({@JsonKey(name: "tags") List<PredictiveSearchWorksTag> tags});
}

/// @nodoc
class _$PredictiveSearchWorksCopyWithImpl<$Res,
        $Val extends PredictiveSearchWorks>
    implements $PredictiveSearchWorksCopyWith<$Res> {
  _$PredictiveSearchWorksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PredictiveSearchWorks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
  }) {
    return _then(_value.copyWith(
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<PredictiveSearchWorksTag>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PredictiveSearchWorksImplCopyWith<$Res>
    implements $PredictiveSearchWorksCopyWith<$Res> {
  factory _$$PredictiveSearchWorksImplCopyWith(
          _$PredictiveSearchWorksImpl value,
          $Res Function(_$PredictiveSearchWorksImpl) then) =
      __$$PredictiveSearchWorksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "tags") List<PredictiveSearchWorksTag> tags});
}

/// @nodoc
class __$$PredictiveSearchWorksImplCopyWithImpl<$Res>
    extends _$PredictiveSearchWorksCopyWithImpl<$Res,
        _$PredictiveSearchWorksImpl>
    implements _$$PredictiveSearchWorksImplCopyWith<$Res> {
  __$$PredictiveSearchWorksImplCopyWithImpl(_$PredictiveSearchWorksImpl _value,
      $Res Function(_$PredictiveSearchWorksImpl) _then)
      : super(_value, _then);

  /// Create a copy of PredictiveSearchWorks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tags = null,
  }) {
    return _then(_$PredictiveSearchWorksImpl(
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<PredictiveSearchWorksTag>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PredictiveSearchWorksImpl implements _PredictiveSearchWorks {
  const _$PredictiveSearchWorksImpl(
      {@JsonKey(name: "tags")
      required final List<PredictiveSearchWorksTag> tags})
      : _tags = tags;

  factory _$PredictiveSearchWorksImpl.fromJson(Map<String, dynamic> json) =>
      _$$PredictiveSearchWorksImplFromJson(json);

  final List<PredictiveSearchWorksTag> _tags;
  @override
  @JsonKey(name: "tags")
  List<PredictiveSearchWorksTag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'PredictiveSearchWorks(tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictiveSearchWorksImpl &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tags));

  /// Create a copy of PredictiveSearchWorks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictiveSearchWorksImplCopyWith<_$PredictiveSearchWorksImpl>
      get copyWith => __$$PredictiveSearchWorksImplCopyWithImpl<
          _$PredictiveSearchWorksImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PredictiveSearchWorksImplToJson(
      this,
    );
  }
}

abstract class _PredictiveSearchWorks implements PredictiveSearchWorks {
  const factory _PredictiveSearchWorks(
          {@JsonKey(name: "tags")
          required final List<PredictiveSearchWorksTag> tags}) =
      _$PredictiveSearchWorksImpl;

  factory _PredictiveSearchWorks.fromJson(Map<String, dynamic> json) =
      _$PredictiveSearchWorksImpl.fromJson;

  @override
  @JsonKey(name: "tags")
  List<PredictiveSearchWorksTag> get tags;

  /// Create a copy of PredictiveSearchWorks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictiveSearchWorksImplCopyWith<_$PredictiveSearchWorksImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PredictiveSearchWorksTag _$PredictiveSearchWorksTagFromJson(
    Map<String, dynamic> json) {
  return _PredictiveSearchWorksTag.fromJson(json);
}

/// @nodoc
mixin _$PredictiveSearchWorksTag {
  @JsonKey(name: "name")
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "translated_name")
  String? get translatedName => throw _privateConstructorUsedError;

  /// Serializes this PredictiveSearchWorksTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PredictiveSearchWorksTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PredictiveSearchWorksTagCopyWith<PredictiveSearchWorksTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PredictiveSearchWorksTagCopyWith<$Res> {
  factory $PredictiveSearchWorksTagCopyWith(PredictiveSearchWorksTag value,
          $Res Function(PredictiveSearchWorksTag) then) =
      _$PredictiveSearchWorksTagCopyWithImpl<$Res, PredictiveSearchWorksTag>;
  @useResult
  $Res call(
      {@JsonKey(name: "name") String name,
      @JsonKey(name: "translated_name") String? translatedName});
}

/// @nodoc
class _$PredictiveSearchWorksTagCopyWithImpl<$Res,
        $Val extends PredictiveSearchWorksTag>
    implements $PredictiveSearchWorksTagCopyWith<$Res> {
  _$PredictiveSearchWorksTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PredictiveSearchWorksTag
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
abstract class _$$PredictiveSearchWorksTagImplCopyWith<$Res>
    implements $PredictiveSearchWorksTagCopyWith<$Res> {
  factory _$$PredictiveSearchWorksTagImplCopyWith(
          _$PredictiveSearchWorksTagImpl value,
          $Res Function(_$PredictiveSearchWorksTagImpl) then) =
      __$$PredictiveSearchWorksTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "name") String name,
      @JsonKey(name: "translated_name") String? translatedName});
}

/// @nodoc
class __$$PredictiveSearchWorksTagImplCopyWithImpl<$Res>
    extends _$PredictiveSearchWorksTagCopyWithImpl<$Res,
        _$PredictiveSearchWorksTagImpl>
    implements _$$PredictiveSearchWorksTagImplCopyWith<$Res> {
  __$$PredictiveSearchWorksTagImplCopyWithImpl(
      _$PredictiveSearchWorksTagImpl _value,
      $Res Function(_$PredictiveSearchWorksTagImpl) _then)
      : super(_value, _then);

  /// Create a copy of PredictiveSearchWorksTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? translatedName = freezed,
  }) {
    return _then(_$PredictiveSearchWorksTagImpl(
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
class _$PredictiveSearchWorksTagImpl implements _PredictiveSearchWorksTag {
  const _$PredictiveSearchWorksTagImpl(
      {@JsonKey(name: "name") required this.name,
      @JsonKey(name: "translated_name") this.translatedName});

  factory _$PredictiveSearchWorksTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$PredictiveSearchWorksTagImplFromJson(json);

  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "translated_name")
  final String? translatedName;

  @override
  String toString() {
    return 'PredictiveSearchWorksTag(name: $name, translatedName: $translatedName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PredictiveSearchWorksTagImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.translatedName, translatedName) ||
                other.translatedName == translatedName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, translatedName);

  /// Create a copy of PredictiveSearchWorksTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PredictiveSearchWorksTagImplCopyWith<_$PredictiveSearchWorksTagImpl>
      get copyWith => __$$PredictiveSearchWorksTagImplCopyWithImpl<
          _$PredictiveSearchWorksTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PredictiveSearchWorksTagImplToJson(
      this,
    );
  }
}

abstract class _PredictiveSearchWorksTag implements PredictiveSearchWorksTag {
  const factory _PredictiveSearchWorksTag(
          {@JsonKey(name: "name") required final String name,
          @JsonKey(name: "translated_name") final String? translatedName}) =
      _$PredictiveSearchWorksTagImpl;

  factory _PredictiveSearchWorksTag.fromJson(Map<String, dynamic> json) =
      _$PredictiveSearchWorksTagImpl.fromJson;

  @override
  @JsonKey(name: "name")
  String get name;
  @override
  @JsonKey(name: "translated_name")
  String? get translatedName;

  /// Create a copy of PredictiveSearchWorksTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PredictiveSearchWorksTagImplCopyWith<_$PredictiveSearchWorksTagImpl>
      get copyWith => throw _privateConstructorUsedError;
}
