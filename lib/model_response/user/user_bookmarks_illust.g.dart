// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bookmarks_illust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBookmarksIllust _$UserBookmarksIllustFromJson(Map<String, dynamic> json) {
  return UserBookmarksIllust(
    (json['illusts'] as List<dynamic>)
        .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['next_url'] as String,
  );
}

Map<String, dynamic> _$UserBookmarksIllustToJson(
        UserBookmarksIllust instance) =>
    <String, dynamic>{
      'illusts': instance.illusts,
      'next_url': instance.nextUrl,
    };
