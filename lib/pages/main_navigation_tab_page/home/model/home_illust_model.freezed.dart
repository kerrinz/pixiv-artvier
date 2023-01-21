// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_illust_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeIllustModel {
  List<CommonIllust> get ranking => throw _privateConstructorUsedError;
  List<CommonIllust> get recommended => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeIllustModelCopyWith<HomeIllustModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeIllustModelCopyWith<$Res> {
  factory $HomeIllustModelCopyWith(
          HomeIllustModel value, $Res Function(HomeIllustModel) then) =
      _$HomeIllustModelCopyWithImpl<$Res, HomeIllustModel>;
  @useResult
  $Res call({List<CommonIllust> ranking, List<CommonIllust> recommended});
}

/// @nodoc
class _$HomeIllustModelCopyWithImpl<$Res, $Val extends HomeIllustModel>
    implements $HomeIllustModelCopyWith<$Res> {
  _$HomeIllustModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ranking = null,
    Object? recommended = null,
  }) {
    return _then(_value.copyWith(
      ranking: null == ranking
          ? _value.ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as List<CommonIllust>,
      recommended: null == recommended
          ? _value.recommended
          : recommended // ignore: cast_nullable_to_non_nullable
              as List<CommonIllust>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeIllustModelCopyWith<$Res>
    implements $HomeIllustModelCopyWith<$Res> {
  factory _$$_HomeIllustModelCopyWith(
          _$_HomeIllustModel value, $Res Function(_$_HomeIllustModel) then) =
      __$$_HomeIllustModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CommonIllust> ranking, List<CommonIllust> recommended});
}

/// @nodoc
class __$$_HomeIllustModelCopyWithImpl<$Res>
    extends _$HomeIllustModelCopyWithImpl<$Res, _$_HomeIllustModel>
    implements _$$_HomeIllustModelCopyWith<$Res> {
  __$$_HomeIllustModelCopyWithImpl(
      _$_HomeIllustModel _value, $Res Function(_$_HomeIllustModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ranking = null,
    Object? recommended = null,
  }) {
    return _then(_$_HomeIllustModel(
      ranking: null == ranking
          ? _value._ranking
          : ranking // ignore: cast_nullable_to_non_nullable
              as List<CommonIllust>,
      recommended: null == recommended
          ? _value._recommended
          : recommended // ignore: cast_nullable_to_non_nullable
              as List<CommonIllust>,
    ));
  }
}

/// @nodoc

class _$_HomeIllustModel implements _HomeIllustModel {
  const _$_HomeIllustModel(
      {required final List<CommonIllust> ranking,
      required final List<CommonIllust> recommended})
      : _ranking = ranking,
        _recommended = recommended;

  final List<CommonIllust> _ranking;
  @override
  List<CommonIllust> get ranking {
    if (_ranking is EqualUnmodifiableListView) return _ranking;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ranking);
  }

  final List<CommonIllust> _recommended;
  @override
  List<CommonIllust> get recommended {
    if (_recommended is EqualUnmodifiableListView) return _recommended;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recommended);
  }

  @override
  String toString() {
    return 'HomeIllustModel(ranking: $ranking, recommended: $recommended)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeIllustModel &&
            const DeepCollectionEquality().equals(other._ranking, _ranking) &&
            const DeepCollectionEquality()
                .equals(other._recommended, _recommended));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_ranking),
      const DeepCollectionEquality().hash(_recommended));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeIllustModelCopyWith<_$_HomeIllustModel> get copyWith =>
      __$$_HomeIllustModelCopyWithImpl<_$_HomeIllustModel>(this, _$identity);
}

abstract class _HomeIllustModel implements HomeIllustModel {
  const factory _HomeIllustModel(
      {required final List<CommonIllust> ranking,
      required final List<CommonIllust> recommended}) = _$_HomeIllustModel;

  @override
  List<CommonIllust> get ranking;
  @override
  List<CommonIllust> get recommended;
  @override
  @JsonKey(ignore: true)
  _$$_HomeIllustModelCopyWith<_$_HomeIllustModel> get copyWith =>
      throw _privateConstructorUsedError;
}
