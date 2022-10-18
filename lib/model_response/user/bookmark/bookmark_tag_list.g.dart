// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'bookmark_tag_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookmarkTagList _$BookmarkTagListFromJson(Map<String, dynamic> json) =>
    BookmarkTagList(
      (json['bookmark_tags'] as List<dynamic>?)
          ?.map((e) => BookmarkTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$BookmarkTagListToJson(BookmarkTagList instance) =>
    <String, dynamic>{
      'bookmark_tags': instance.bookmarkTags?.map((e) => e.toJson()).toList(),
      'next_url': instance.nextUrl,
    };
