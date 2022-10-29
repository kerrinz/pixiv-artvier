// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'common_user_previews_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonUserPreviewsList _$CommonUserPreviewsListFromJson(
        Map<String, dynamic> json) =>
    CommonUserPreviewsList(
      (json['user_previews'] as List<dynamic>)
          .map((e) => CommonUserPreviews.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$CommonUserPreviewsListToJson(
        CommonUserPreviewsList instance) =>
    <String, dynamic>{
      'user_previews': instance.users,
      'next_url': instance.nextUrl,
    };
