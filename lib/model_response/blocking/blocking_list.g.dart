// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'blocking_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BlockingListResponseImpl _$$BlockingListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BlockingListResponseImpl(
      mutedTags: json['muted_tags'] as List<dynamic>,
      mutedUsers: (json['muted_users'] as List<dynamic>)
          .map((e) => MutedUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      mutedCount: (json['muted_count'] as num).toInt(),
      mutedTagsCount: (json['muted_tags_count'] as num).toInt(),
      mutedUsersCount: (json['muted_users_count'] as num).toInt(),
      muteLimitCount: (json['mute_limit_count'] as num).toInt(),
      forText: ForText.fromJson(json['for_text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BlockingListResponseImplToJson(
        _$BlockingListResponseImpl instance) =>
    <String, dynamic>{
      'muted_tags': instance.mutedTags,
      'muted_users': instance.mutedUsers,
      'muted_count': instance.mutedCount,
      'muted_tags_count': instance.mutedTagsCount,
      'muted_users_count': instance.mutedUsersCount,
      'mute_limit_count': instance.muteLimitCount,
      'for_text': instance.forText,
    };

_$ForTextImpl _$$ForTextImplFromJson(Map<String, dynamic> json) =>
    _$ForTextImpl(
      muteLimitCountIfNoPremium:
          (json['mute_limit_count_if_no_premium'] as num).toInt(),
      muteLimitCountIfPremium:
          (json['mute_limit_count_if_premium'] as num).toInt(),
    );

Map<String, dynamic> _$$ForTextImplToJson(_$ForTextImpl instance) =>
    <String, dynamic>{
      'mute_limit_count_if_no_premium': instance.muteLimitCountIfNoPremium,
      'mute_limit_count_if_premium': instance.muteLimitCountIfPremium,
    };

_$MutedUserImpl _$$MutedUserImplFromJson(Map<String, dynamic> json) =>
    _$MutedUserImpl(
      user: CommonUser.fromJson(json['user'] as Map<String, dynamic>),
      isPremiumSlot: json['is_premium_slot'] as bool,
    );

Map<String, dynamic> _$$MutedUserImplToJson(_$MutedUserImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'is_premium_slot': instance.isPremiumSlot,
    };

_$ProfileImageUrlsImpl _$$ProfileImageUrlsImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileImageUrlsImpl(
      medium: json['medium'] as String,
    );

Map<String, dynamic> _$$ProfileImageUrlsImplToJson(
        _$ProfileImageUrlsImpl instance) =>
    <String, dynamic>{
      'medium': instance.medium,
    };
