// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illust_comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllustComments _$IllustCommentsFromJson(Map<String, dynamic> json) {
  return IllustComments(
    (json['comments'] as List<dynamic>)
        .map((e) => Comments.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['next_url'] as String?,
  );
}

Map<String, dynamic> _$IllustCommentsToJson(IllustComments instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'next_url': instance.nextUrl,
    };

Comments _$CommentsFromJson(Map<String, dynamic> json) {
  return Comments(
    json['id'] as int,
    json['comment'] as String,
    json['date'] as String,
    User.fromJson(json['user'] as Map<String, dynamic>),
    json['has_replies'] as bool,
  );
}

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'date': instance.date,
      'user': instance.user,
      'has_replies': instance.hasReplies,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['id'] as int,
    json['name'] as String,
    json['account'] as String,
    Profile_image_urls.fromJson(
        json['profile_image_urls'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'profile_image_urls': instance.profileImageUrls,
    };

Profile_image_urls _$Profile_image_urlsFromJson(Map<String, dynamic> json) {
  return Profile_image_urls(
    json['medium'] as String,
  );
}

Map<String, dynamic> _$Profile_image_urlsToJson(Profile_image_urls instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };
