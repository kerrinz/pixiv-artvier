// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'illusts_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllustsSearchResult _$IllustsSearchResultFromJson(Map<String, dynamic> json) =>
    IllustsSearchResult(
      (json['illusts'] as List<dynamic>)
          .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
      json['search_span_limit'] as int,
    );

Map<String, dynamic> _$IllustsSearchResultToJson(
        IllustsSearchResult instance) =>
    <String, dynamic>{
      'illusts': instance.illusts,
      'next_url': instance.nextUrl,
      'search_span_limit': instance.searchSpanLimit,
    };
