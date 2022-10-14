// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_user_previews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonUserPreviews _$CommonUserPreviewsFromJson(Map<String, dynamic> json) =>
    CommonUserPreviews(
      CommonUser.fromJson(json['user'] as Map<String, dynamic>),
      (json['illusts'] as List<dynamic>)
          .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['novels'] as List<dynamic>)
          .map((e) => CommonNovel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_muted'] as bool,
    );

Map<String, dynamic> _$CommonUserPreviewsToJson(CommonUserPreviews instance) =>
    <String, dynamic>{
      'user': instance.user,
      'illusts': instance.illusts,
      'novels': instance.novels,
      'is_muted': instance.isMuted,
    };
