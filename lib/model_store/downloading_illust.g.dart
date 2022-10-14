// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloading_illust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadingIllust _$DownloadingIllustFromJson(Map<String, dynamic> json) =>
    DownloadingIllust(
      CommonIllust.fromJson(json['illust'] as Map<String, dynamic>),
      (json['percentage'] as num).toDouble(),
      $enumDecode(_$DownloadingStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$DownloadingIllustToJson(DownloadingIllust instance) =>
    <String, dynamic>{
      'illust': instance.illust,
      'percentage': instance.percentage,
      'status': _$DownloadingStatusEnumMap[instance.status]!,
    };

const _$DownloadingStatusEnumMap = {
  DownloadingStatus.downloading: 'downloading',
  DownloadingStatus.pause: 'pause',
  DownloadingStatus.failed: 'failed',
};
