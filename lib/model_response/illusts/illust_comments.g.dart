// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'illust_comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllustComments _$IllustCommentsFromJson(Map<String, dynamic> json) =>
    IllustComments(
      (json['comments'] as List<dynamic>)
          .map((e) => Comments.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$IllustCommentsToJson(IllustComments instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'next_url': instance.nextUrl,
    };

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      (json['id'] as num).toInt(),
      json['comment'] as String,
      DateTime.parse(json['date'] as String),
      User.fromJson(json['user'] as Map<String, dynamic>),
      json['has_replies'] as bool,
      json['stamp'] == null
          ? null
          : Stamp.fromJson(json['stamp'] as Map<String, dynamic>),
      json['cacheReplies'] == null
          ? null
          : IllustComments.fromJson(
              json['cacheReplies'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'date': instance.date.toIso8601String(),
      'user': instance.user,
      'has_replies': instance.hasReplies,
      'stamp': instance.stamp,
      'cacheReplies': instance.cacheReplies,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['account'] as String,
      Profile_image_urls.fromJson(
          json['profile_image_urls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'profile_image_urls': instance.profileImageUrls,
    };

Profile_image_urls _$Profile_image_urlsFromJson(Map<String, dynamic> json) =>
    Profile_image_urls(
      json['medium'] as String,
    );

Map<String, dynamic> _$Profile_image_urlsToJson(Profile_image_urls instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };

Stamp _$StampFromJson(Map<String, dynamic> json) => Stamp(
      (json['stamp_id'] as num).toInt(),
      json['stamp_url'] as String,
    );

Map<String, dynamic> _$StampToJson(Stamp instance) => <String, dynamic>{
      'stamp_id': instance.stampId,
      'stamp_url': instance.stampUrl,
    };
