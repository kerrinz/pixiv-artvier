import 'package:json_annotation/json_annotation.dart';

part 'common_user.g.dart';


@JsonSerializable()
  class CommonUser extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'account')
  String account;

  @JsonKey(name: 'profile_image_urls')
  Profile_image_urls profileImageUrls;

  @JsonKey(name: 'is_followed')
  bool isFollowed;

  CommonUser(this.id,this.name,this.account,this.profileImageUrls,this.isFollowed,);

  factory CommonUser.fromJson(Map<String, dynamic> srcJson) => _$CommonUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonUserToJson(this);

}
  
@JsonSerializable()
  class Profile_image_urls extends Object {

  @JsonKey(name: 'medium')
  String medium;

  Profile_image_urls(this.medium,);

  factory Profile_image_urls.fromJson(Map<String, dynamic> srcJson) => _$Profile_image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Profile_image_urlsToJson(this);

}
