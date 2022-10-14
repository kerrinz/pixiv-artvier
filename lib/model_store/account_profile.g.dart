// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountProfile _$AccountProfileFromJson(Map<String, dynamic> json) =>
    AccountProfile(
      json['access_token'] as String,
      json['expires_in'] as int,
      json['token_type'] as String,
      json['scope'] as String,
      json['refresh_token'] as String,
      User.fromJson(json['user'] as Map<String, dynamic>),
    )..expiredTimestamp = json['expired_timestamp'] as int?;

Map<String, dynamic> _$AccountProfileToJson(AccountProfile instance) =>
    <String, dynamic>{
      'expired_timestamp': instance.expiredTimestamp,
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      'token_type': instance.tokenType,
      'scope': instance.scope,
      'refresh_token': instance.refreshToken,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['profile_image_urls'] == null
          ? null
          : Profile_image_urls.fromJson(
              json['profile_image_urls'] as Map<String, dynamic>),
      json['id'] as String,
      json['name'] as String,
      json['account'] as String,
      json['mail_address'] as String,
      json['is_premium'] as bool,
      json['x_restrict'] as int,
      json['is_mail_authorized'] as bool,
      json['require_policy_agreement'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'profile_image_urls': instance.profileImageUrls,
      'id': instance.id,
      'name': instance.name,
      'account': instance.account,
      'mail_address': instance.mailAddress,
      'is_premium': instance.isPremium,
      'x_restrict': instance.xRestrict,
      'is_mail_authorized': instance.isMailAuthorized,
      'require_policy_agreement': instance.requirePolicyAgreement,
    };

Profile_image_urls _$Profile_image_urlsFromJson(Map<String, dynamic> json) =>
    Profile_image_urls(
      json['px_16x16'] as String,
      json['px_50x50'] as String,
      json['px_170x170'] as String,
    );

Map<String, dynamic> _$Profile_image_urlsToJson(Profile_image_urls instance) =>
    <String, dynamic>{
      'px_16x16': instance.px16x16,
      'px_50x50': instance.px50x50,
      'px_170x170': instance.px170x170,
    };
