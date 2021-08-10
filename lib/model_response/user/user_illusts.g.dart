// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_illusts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserIllusts _$UserIllustsFromJson(Map<String, dynamic> json) {
  return UserIllusts(
    (json['illusts'] as List<dynamic>)
        .map((e) => CommonIllust.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['next_url'] as String?,
  );
}

Map<String, dynamic> _$UserIllustsToJson(UserIllusts instance) =>
    <String, dynamic>{
      'illusts': instance.illusts,
      'next_url': instance.nextUrl,
    };
