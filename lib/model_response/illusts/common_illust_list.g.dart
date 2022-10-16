// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'common_illust_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonIllustList _$CommonIllustListFromJson(Map<String, dynamic> json) =>
    CommonIllustList(
      (json['illusts'] as List<dynamic>)
          .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String?,
    );

Map<String, dynamic> _$CommonIllustListToJson(CommonIllustList instance) =>
    <String, dynamic>{
      'illusts': instance.illusts,
      'next_url': instance.nextUrl,
    };
