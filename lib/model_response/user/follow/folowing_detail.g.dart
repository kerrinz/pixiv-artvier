// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'folowing_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TheFollowingDetail _$TheFollowingDetailFromJson(Map<String, dynamic> json) =>
    TheFollowingDetail()
      ..detail = json['follow_detail'] == null
          ? null
          : UserFollowingDetail.fromJson(
              json['follow_detail'] as Map<String, dynamic>);

Map<String, dynamic> _$TheFollowingDetailToJson(TheFollowingDetail instance) =>
    <String, dynamic>{
      'follow_detail': instance.detail?.toJson(),
    };

UserFollowingDetail _$UserFollowingDetailFromJson(Map<String, dynamic> json) =>
    UserFollowingDetail(
      isFollowed: json['is_followed'] as bool?,
      restrict: json['restrict'] as String?,
    );

Map<String, dynamic> _$UserFollowingDetailToJson(
        UserFollowingDetail instance) =>
    <String, dynamic>{
      'is_followed': instance.isFollowed,
      'restrict': instance.restrict,
    };
