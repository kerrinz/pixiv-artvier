// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_bar_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommentBarModel {
  /// 回复哪个评论
  int? get parentCommentId => throw _privateConstructorUsedError;
  String? get parentCommentName => throw _privateConstructorUsedError;

  /// 是否正在发布中
  bool get isSending => throw _privateConstructorUsedError;

  /// 是否处于激活状态
  bool get isActived => throw _privateConstructorUsedError;

  /// 输入框的内容
  String? get comment => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentBarModelCopyWith<CommentBarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentBarModelCopyWith<$Res> {
  factory $CommentBarModelCopyWith(
          CommentBarModel value, $Res Function(CommentBarModel) then) =
      _$CommentBarModelCopyWithImpl<$Res, CommentBarModel>;
  @useResult
  $Res call(
      {int? parentCommentId,
      String? parentCommentName,
      bool isSending,
      bool isActived,
      String? comment});
}

/// @nodoc
class _$CommentBarModelCopyWithImpl<$Res, $Val extends CommentBarModel>
    implements $CommentBarModelCopyWith<$Res> {
  _$CommentBarModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentCommentId = freezed,
    Object? parentCommentName = freezed,
    Object? isSending = null,
    Object? isActived = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      parentCommentId: freezed == parentCommentId
          ? _value.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentCommentName: freezed == parentCommentName
          ? _value.parentCommentName
          : parentCommentName // ignore: cast_nullable_to_non_nullable
              as String?,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isActived: null == isActived
          ? _value.isActived
          : isActived // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentBarModelImplCopyWith<$Res>
    implements $CommentBarModelCopyWith<$Res> {
  factory _$$CommentBarModelImplCopyWith(_$CommentBarModelImpl value,
          $Res Function(_$CommentBarModelImpl) then) =
      __$$CommentBarModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? parentCommentId,
      String? parentCommentName,
      bool isSending,
      bool isActived,
      String? comment});
}

/// @nodoc
class __$$CommentBarModelImplCopyWithImpl<$Res>
    extends _$CommentBarModelCopyWithImpl<$Res, _$CommentBarModelImpl>
    implements _$$CommentBarModelImplCopyWith<$Res> {
  __$$CommentBarModelImplCopyWithImpl(
      _$CommentBarModelImpl _value, $Res Function(_$CommentBarModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentCommentId = freezed,
    Object? parentCommentName = freezed,
    Object? isSending = null,
    Object? isActived = null,
    Object? comment = freezed,
  }) {
    return _then(_$CommentBarModelImpl(
      parentCommentId: freezed == parentCommentId
          ? _value.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentCommentName: freezed == parentCommentName
          ? _value.parentCommentName
          : parentCommentName // ignore: cast_nullable_to_non_nullable
              as String?,
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isActived: null == isActived
          ? _value.isActived
          : isActived // ignore: cast_nullable_to_non_nullable
              as bool,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CommentBarModelImpl implements _CommentBarModel {
  const _$CommentBarModelImpl(
      {this.parentCommentId,
      this.parentCommentName,
      this.isSending = false,
      this.isActived = false,
      this.comment});

  /// 回复哪个评论
  @override
  final int? parentCommentId;
  @override
  final String? parentCommentName;

  /// 是否正在发布中
  @override
  @JsonKey()
  final bool isSending;

  /// 是否处于激活状态
  @override
  @JsonKey()
  final bool isActived;

  /// 输入框的内容
  @override
  final String? comment;

  @override
  String toString() {
    return 'CommentBarModel(parentCommentId: $parentCommentId, parentCommentName: $parentCommentName, isSending: $isSending, isActived: $isActived, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentBarModelImpl &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            (identical(other.parentCommentName, parentCommentName) ||
                other.parentCommentName == parentCommentName) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isActived, isActived) ||
                other.isActived == isActived) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(runtimeType, parentCommentId,
      parentCommentName, isSending, isActived, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentBarModelImplCopyWith<_$CommentBarModelImpl> get copyWith =>
      __$$CommentBarModelImplCopyWithImpl<_$CommentBarModelImpl>(
          this, _$identity);
}

abstract class _CommentBarModel implements CommentBarModel {
  const factory _CommentBarModel(
      {final int? parentCommentId,
      final String? parentCommentName,
      final bool isSending,
      final bool isActived,
      final String? comment}) = _$CommentBarModelImpl;

  @override

  /// 回复哪个评论
  int? get parentCommentId;
  @override
  String? get parentCommentName;
  @override

  /// 是否正在发布中
  bool get isSending;
  @override

  /// 是否处于激活状态
  bool get isActived;
  @override

  /// 输入框的内容
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$CommentBarModelImplCopyWith<_$CommentBarModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
