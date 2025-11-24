// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'common_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommonUserImpl _$$CommonUserImplFromJson(Map<String, dynamic> json) =>
    _$CommonUserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      account: json['account'] as String?,
      profileImageUrls: Profile_image_urls.fromJson(
          json['profile_image_urls'] as Map<String, dynamic>),
      comment: json['comment'] as String?,
      isFollowed: json['is_followed'] as bool?,
      isAcceptRequest: json['is_accept_request'] as bool?,
      isAccessBlockingUser: json['is_access_blocking_user'] as bool?,
    );

Map<String, dynamic> _$$CommonUserImplToJson(_$CommonUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'profile_image_urls': instance.profileImageUrls,
      'comment': instance.comment,
      'is_followed': instance.isFollowed,
      'is_accept_request': instance.isAcceptRequest,
      'is_access_blocking_user': instance.isAccessBlockingUser,
    };

_$Profile_image_urlsImpl _$$Profile_image_urlsImplFromJson(
        Map<String, dynamic> json) =>
    _$Profile_image_urlsImpl(
      medium: json['medium'] as String,
    );

Map<String, dynamic> _$$Profile_image_urlsImplToJson(
        _$Profile_image_urlsImpl instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };
