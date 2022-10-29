import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/user/common_user.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';

part 'common_user_previews_list.g.dart';


@JsonSerializable()
/// - 与漫画通用
class CommonUserPreviewsList extends Object {

  @JsonKey(name: 'user_previews')
  List<CommonUserPreviews> users;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  CommonUserPreviewsList(this.users, this.nextUrl);

  factory CommonUserPreviewsList.fromJson(Map<String, dynamic> srcJson) => _$CommonUserPreviewsListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonUserPreviewsListToJson(this);

}
