// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'common_novel_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonNovelList _$CommonNovelListFromJson(Map<String, dynamic> json) =>
    CommonNovelList(
      (json['novels'] as List<dynamic>)
          .map((e) => CommonNovel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$CommonNovelListToJson(CommonNovelList instance) =>
    <String, dynamic>{
      'novels': instance.novels,
      'next_url': instance.nextUrl,
    };
