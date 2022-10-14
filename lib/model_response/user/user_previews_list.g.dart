// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_previews_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreviewsList _$UserPreviewsListFromJson(Map<String, dynamic> json) =>
    UserPreviewsList(
      (json['user_previews'] as List<dynamic>)
          .map((e) => CommonUserPreviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$UserPreviewsListToJson(UserPreviewsList instance) =>
    <String, dynamic>{
      'user_previews': instance.userPreviews,
      'next_url': instance.nextUrl,
    };
