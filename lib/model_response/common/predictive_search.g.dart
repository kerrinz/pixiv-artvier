// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'predictive_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PredictiveSearchWorksImpl _$$PredictiveSearchWorksImplFromJson(
        Map<String, dynamic> json) =>
    _$PredictiveSearchWorksImpl(
      tags: (json['tags'] as List<dynamic>)
          .map((e) =>
              PredictiveSearchWorksTag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PredictiveSearchWorksImplToJson(
        _$PredictiveSearchWorksImpl instance) =>
    <String, dynamic>{
      'tags': instance.tags,
    };

_$PredictiveSearchWorksTagImpl _$$PredictiveSearchWorksTagImplFromJson(
        Map<String, dynamic> json) =>
    _$PredictiveSearchWorksTagImpl(
      name: json['name'] as String,
      translatedName: json['translated_name'] as String?,
    );

Map<String, dynamic> _$$PredictiveSearchWorksTagImplToJson(
        _$PredictiveSearchWorksTagImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'translated_name': instance.translatedName,
    };
