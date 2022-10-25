// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'artwork_collect_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtworkCollectDetail _$ArtworkCollectDetailFromJson(
        Map<String, dynamic> json) =>
    ArtworkCollectDetail()
      ..detail = json['bookmark_detail'] == null
          ? null
          : WorksCollectDetail.fromJson(
              json['bookmark_detail'] as Map<String, dynamic>);

Map<String, dynamic> _$ArtworkCollectDetailToJson(
        ArtworkCollectDetail instance) =>
    <String, dynamic>{
      'bookmark_detail': instance.detail?.toJson(),
    };

WorksCollectDetail _$WorksCollectDetailFromJson(Map<String, dynamic> json) =>
    WorksCollectDetail()
      ..isBookmarked = json['is_bookmarked'] as bool?
      ..tags = (json['tags'] as List<dynamic>?)
          ?.map((e) => WorksCollectTag.fromJson(e as Map<String, dynamic>))
          .toList()
      ..restrict = json['restrict'] as String?;

Map<String, dynamic> _$WorksCollectDetailToJson(WorksCollectDetail instance) =>
    <String, dynamic>{
      'is_bookmarked': instance.isBookmarked,
      'tags': instance.tags?.map((e) => e.toJson()).toList(),
      'restrict': instance.restrict,
    };

WorksCollectTag _$WorksCollectTagFromJson(Map<String, dynamic> json) =>
    WorksCollectTag()
      ..name = json['name'] as String?
      ..isRegistered = json['is_registered'] as bool?;

Map<String, dynamic> _$WorksCollectTagToJson(WorksCollectTag instance) =>
    <String, dynamic>{
      'name': instance.name,
      'is_registered': instance.isRegistered,
    };
