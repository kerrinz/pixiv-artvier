// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'marker_novel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MarkedNovelsResponseImpl _$$MarkedNovelsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MarkedNovelsResponseImpl(
      markedNovels: (json['marked_novels'] as List<dynamic>)
          .map((e) => MarkedNovel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextUrl: json['next_url'],
    );

Map<String, dynamic> _$$MarkedNovelsResponseImplToJson(
        _$MarkedNovelsResponseImpl instance) =>
    <String, dynamic>{
      'marked_novels': instance.markedNovels,
      'next_url': instance.nextUrl,
    };

_$MarkedNovelImpl _$$MarkedNovelImplFromJson(Map<String, dynamic> json) =>
    _$MarkedNovelImpl(
      novel: CommonNovel.fromJson(json['novel'] as Map<String, dynamic>),
      novelMarker: json['novel_marker'] == null
          ? null
          : NovelMarker.fromJson(json['novel_marker'] as Map<String, dynamic>),
      markerState:
          $enumDecodeNullable(_$MarkerStateEnumMap, json['markerState']),
    );

Map<String, dynamic> _$$MarkedNovelImplToJson(_$MarkedNovelImpl instance) =>
    <String, dynamic>{
      'novel': instance.novel,
      'novel_marker': instance.novelMarker,
      'markerState': _$MarkerStateEnumMap[instance.markerState],
    };

const _$MarkerStateEnumMap = {
  MarkerState.addingMarker: 'addingMarker',
  MarkerState.removingMarker: 'removingMarker',
  MarkerState.marked: 'marked',
  MarkerState.unmarked: 'unmarked',
};

_$NovelMarkerImpl _$$NovelMarkerImplFromJson(Map<String, dynamic> json) =>
    _$NovelMarkerImpl(
      page: (json['page'] as num).toInt(),
    );

Map<String, dynamic> _$$NovelMarkerImplToJson(_$NovelMarkerImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
    };
