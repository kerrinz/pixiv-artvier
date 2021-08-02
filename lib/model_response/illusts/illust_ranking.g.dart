// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'illust_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllustRanking _$IllustRankingFromJson(Map<String, dynamic> json) {
  return IllustRanking(
    (json['illusts'] as List<dynamic>)
        .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['next_url'] as String,
  );
}

Map<String, dynamic> _$IllustRankingToJson(IllustRanking instance) =>
    <String, dynamic>{
      'illusts': instance.illusts,
      'next_url': instance.nextUrl,
    };
