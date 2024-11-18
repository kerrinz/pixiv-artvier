// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'common_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonUser _$CommonUserFromJson(Map<String, dynamic> json) => CommonUser(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['account'] as String,
      Profile_image_urls.fromJson(
          json['profile_image_urls'] as Map<String, dynamic>),
      json['comment'] as String?,
      json['is_followed'] as bool?,
    );

Map<String, dynamic> _$CommonUserToJson(CommonUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'profile_image_urls': instance.profileImageUrls,
      'comment': instance.comment,
      'is_followed': instance.isFollowed,
    };

Profile_image_urls _$Profile_image_urlsFromJson(Map<String, dynamic> json) =>
    Profile_image_urls(
      json['medium'] as String,
    );

Map<String, dynamic> _$Profile_image_urlsToJson(Profile_image_urls instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };
