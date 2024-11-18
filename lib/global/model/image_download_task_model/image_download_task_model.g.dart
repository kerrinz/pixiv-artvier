// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'image_download_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageDownloadTaskModelImpl _$$ImageDownloadTaskModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageDownloadTaskModelImpl(
      worksId: json['worksId'] as String,
      pIndex: (json['pIndex'] as num).toInt(),
      downloadState: (json['downloadState'] as num).toInt(),
      receivedBytes: (json['receivedBytes'] as num?)?.toDouble(),
      totalBytes: (json['totalBytes'] as num?)?.toDouble(),
      url: json['url'] as String,
      title: json['title'] as String,
    );

Map<String, dynamic> _$$ImageDownloadTaskModelImplToJson(
        _$ImageDownloadTaskModelImpl instance) =>
    <String, dynamic>{
      'worksId': instance.worksId,
      'pIndex': instance.pIndex,
      'downloadState': instance.downloadState,
      'receivedBytes': instance.receivedBytes,
      'totalBytes': instance.totalBytes,
      'url': instance.url,
      'title': instance.title,
    };
