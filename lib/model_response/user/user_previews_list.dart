import 'package:json_annotation/json_annotation.dart';
import 'package:artvier/model_response/user/common_user_previews.dart'; 
  
part 'user_previews_list.g.dart';


@JsonSerializable()
  class UserPreviewsList extends Object {

  @JsonKey(name: 'user_previews')
  List<CommonUserPreviews> userPreviews;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  UserPreviewsList(this.userPreviews,this.nextUrl,);

  factory UserPreviewsList.fromJson(Map<String, dynamic> srcJson) => _$UserPreviewsListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserPreviewsListToJson(this);

}

  