// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloaded_illust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadedIllust _$DownloadedIllustFromJson(Map<String, dynamic> json) {
  return DownloadedIllust(
    json['id'] as int,
    json['title'] as String,
    json['type'] as String,
    json['page_count'] as int,
  );
}

Map<String, dynamic> _$DownloadedIllustToJson(DownloadedIllust instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'page_count': instance.pageCount,
    };
