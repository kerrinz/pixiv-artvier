// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'ugoira.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UgoiraMetadataResult _$UgoiraMetadataResultFromJson(
        Map<String, dynamic> json) =>
    UgoiraMetadataResult(
      UgoiraMetadata.fromJson(json['ugoira_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UgoiraMetadataResultToJson(
        UgoiraMetadataResult instance) =>
    <String, dynamic>{
      'ugoira_metadata': instance.ugoiraMetadata.toJson(),
    };

UgoiraMetadata _$UgoiraMetadataFromJson(Map<String, dynamic> json) =>
    UgoiraMetadata(
      ZipUrls.fromJson(json['zip_urls'] as Map<String, dynamic>),
      (json['frames'] as List<dynamic>)
          .map((e) => Frame.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UgoiraMetadataToJson(UgoiraMetadata instance) =>
    <String, dynamic>{
      'zip_urls': instance.zipUrls.toJson(),
      'frames': instance.frames.map((e) => e.toJson()).toList(),
    };

ZipUrls _$ZipUrlsFromJson(Map<String, dynamic> json) => ZipUrls(
      json['medium'] as String,
    );

Map<String, dynamic> _$ZipUrlsToJson(ZipUrls instance) => <String, dynamic>{
      'medium': instance.medium,
    };

Frame _$FrameFromJson(Map<String, dynamic> json) => Frame(
      json['file'] as String,
      (json['delay'] as num).toInt(),
    );

Map<String, dynamic> _$FrameToJson(Frame instance) => <String, dynamic>{
      'file': instance.file,
      'delay': instance.delay,
    };
