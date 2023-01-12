// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'account_profile.g.dart';


class AccountsProfile  {
  /*
  * 获取Map类型账户集合，值已经实例化
  * */
  static Map<String, AccountProfile> getAccountsMap(String jsonStr){
    Map<String, dynamic> map = json.decode(jsonStr);
    Map<String, AccountProfile> result = <String, AccountProfile>{};
    map.forEach((key, value){
      AccountProfile profile = AccountProfile.fromJson(value);
      result.putIfAbsent(profile.user.id, () => profile);
    });
    return result;
  }

  /*
  * 获取String类型账户集合
  * */
  static String getAccountsString(Map<String, AccountProfile> map){
    return json.encode(map);
  }
}

@JsonSerializable()
class AccountProfile extends Object {

  @JsonKey(name: 'expired_timestamp')
  int? expiredTimestamp; // （非api字段）token过期时间戳

  @JsonKey(name: 'access_token')
  String accessToken;

  @JsonKey(name: 'expires_in')
  int expiresIn;

  @JsonKey(name: 'token_type')
  String tokenType;

  @JsonKey(name: 'scope')
  String scope;

  @JsonKey(name: 'refresh_token')
  String refreshToken;

  @JsonKey(name: 'user')
  User user;

  AccountProfile(this.accessToken,this.expiresIn,this.tokenType,this.scope,this.refreshToken,this.user,);

  factory AccountProfile.fromJson(Map<String, dynamic> srcJson) => _$AccountProfileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AccountProfileToJson(this);

}


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'profile_image_urls')
  Profile_image_urls? profileImageUrls;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'account')
  String account;

  @JsonKey(name: 'mail_address')
  String mailAddress;

  @JsonKey(name: 'is_premium')
  bool isPremium;

  @JsonKey(name: 'x_restrict')
  int xRestrict;

  @JsonKey(name: 'is_mail_authorized')
  bool isMailAuthorized;

  @JsonKey(name: 'require_policy_agreement')
  bool requirePolicyAgreement;

  User(this.profileImageUrls,this.id,this.name,this.account,this.mailAddress,this.isPremium,this.xRestrict,this.isMailAuthorized,this.requirePolicyAgreement,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}


@JsonSerializable()
class Profile_image_urls extends Object {

  @JsonKey(name: 'px_16x16')
  String px16x16;

  @JsonKey(name: 'px_50x50')
  String px50x50;

  @JsonKey(name: 'px_170x170')
  String px170x170;

  Profile_image_urls(this.px16x16,this.px50x50,this.px170x170,);

  factory Profile_image_urls.fromJson(Map<String, dynamic> srcJson) => _$Profile_image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Profile_image_urlsToJson(this);

}

  
