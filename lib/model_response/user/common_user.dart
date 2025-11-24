// ignore_for_file: camel_case_types

import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_user.freezed.dart';
part 'common_user.g.dart';

@freezed
class CommonUser with _$CommonUser {
  const factory CommonUser({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "account") String? account,
    @JsonKey(name: "profile_image_urls") required Profile_image_urls profileImageUrls,

    /// 只在用户详情中存在该字段
    @JsonKey(name: "comment") String? comment,

    /// 已删除或不公开的图片会不存在此字段
    @JsonKey(name: "is_followed") bool? isFollowed,

    /// ？？？
    @JsonKey(name: 'is_accept_request') bool? isAcceptRequest,

    /// 是否屏蔽
    @JsonKey(name: 'is_access_blocking_user') bool? isAccessBlockingUser,
  }) = _CommonUser;

  factory CommonUser.fromJson(Map<String, dynamic> json) => _$CommonUserFromJson(json);
}

@freezed
class Profile_image_urls with _$Profile_image_urls {
  const factory Profile_image_urls({
    @JsonKey(name: 'medium') required String medium,
  }) = _Profile_image_urls;

  factory Profile_image_urls.fromJson(Map<String, dynamic> json) => _$Profile_image_urlsFromJson(json);
}
