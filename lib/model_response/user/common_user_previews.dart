import 'package:json_annotation/json_annotation.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/user/common_user.dart'; 
  
part 'common_user_previews.g.dart';

@JsonSerializable()
  class CommonUserPreviews extends Object {

  @JsonKey(name: 'user')
  CommonUser user;

  @JsonKey(name: 'illusts')
  List<CommonIllust> illusts;

  @JsonKey(name: 'novels')
  List<CommonNovel> novels;

  @JsonKey(name: 'is_muted')
  bool isMuted;

  CommonUserPreviews(this.user,this.illusts,this.novels,this.isMuted,);

  factory CommonUserPreviews.fromJson(Map<String, dynamic> srcJson) => _$CommonUserPreviewsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonUserPreviewsToJson(this);

}
