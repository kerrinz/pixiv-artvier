// To parse this JSON data, do
//
//     final blockingListResponse = blockingListResponseFromJson(jsonString);

import 'package:artvier/model_response/user/common_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'blocking_list.freezed.dart';
part 'blocking_list.g.dart';

BlockingListResponse blockingListResponseFromJson(String str) => BlockingListResponse.fromJson(json.decode(str));

String blockingListResponseToJson(BlockingListResponse data) => json.encode(data.toJson());

@freezed
class BlockingListResponse with _$BlockingListResponse {
  const factory BlockingListResponse({
    @JsonKey(name: "muted_tags") required List<MutedTag> mutedTags,
    @JsonKey(name: "muted_users") required List<MutedUser> mutedUsers,
    @JsonKey(name: "muted_count") required int mutedCount,
    @JsonKey(name: "muted_tags_count") required int mutedTagsCount,
    @JsonKey(name: "muted_users_count") required int mutedUsersCount,
    @JsonKey(name: "mute_limit_count") required int muteLimitCount,
    @JsonKey(name: "for_text") required ForText forText,
  }) = _BlockingListResponse;

  factory BlockingListResponse.fromJson(Map<String, dynamic> json) => _$BlockingListResponseFromJson(json);
}

@freezed
class ForText with _$ForText {
  const factory ForText({
    @JsonKey(name: "mute_limit_count_if_no_premium") required int muteLimitCountIfNoPremium,
    @JsonKey(name: "mute_limit_count_if_premium") required int muteLimitCountIfPremium,
  }) = _ForText;

  factory ForText.fromJson(Map<String, dynamic> json) => _$ForTextFromJson(json);
}

@freezed
class MutedUser with _$MutedUser {
  const factory MutedUser({
    @JsonKey(name: "user") required CommonUser user,
    @JsonKey(name: "is_premium_slot") required bool isPremiumSlot,
  }) = _MutedUser;

  factory MutedUser.fromJson(Map<String, dynamic> json) => _$MutedUserFromJson(json);
}

@freezed
class MutedTag with _$MutedTag {
  const factory MutedTag({
    @JsonKey(name: "tag") required MutedTagInfo tag,
    @JsonKey(name: "is_accept_request") bool? isAcceptRequest,
  }) = _MutedTag;

  factory MutedTag.fromJson(Map<String, dynamic> json) => _$MutedTagFromJson(json);
}

@freezed
class MutedTagInfo with _$MutedTagInfo {
  const factory MutedTagInfo({
    @JsonKey(name: "name") required String name,
  }) = _MutedTagInfo;

  factory MutedTagInfo.fromJson(Map<String, dynamic> json) => _$MutedTagInfoFromJson(json);
}

@freezed
class ProfileImageUrls with _$ProfileImageUrls {
  const factory ProfileImageUrls({
    @JsonKey(name: "medium") required String medium,
  }) = _ProfileImageUrls;

  factory ProfileImageUrls.fromJson(Map<String, dynamic> json) => _$ProfileImageUrlsFromJson(json);
}
