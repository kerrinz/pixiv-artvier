// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloading_illust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadingIllust _$DownloadingIllustFromJson(Map<String, dynamic> json) {
  return DownloadingIllust(
    CommonIllust.fromJson(json['illust'] as Map<String, dynamic>),
    (json['percentage'] as num).toDouble(),
    _$enumDecode(_$DownloadingStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$DownloadingIllustToJson(DownloadingIllust instance) =>
    <String, dynamic>{
      'illust': instance.illust,
      'percentage': instance.percentage,
      'status': _$DownloadingStatusEnumMap[instance.status],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$DownloadingStatusEnumMap = {
  DownloadingStatus.downloading: 'downloading',
  DownloadingStatus.pause: 'pause',
  DownloadingStatus.failed: 'failed',
};
