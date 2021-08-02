import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

part 'user_bookmarks_illust.g.dart';


@JsonSerializable()
class UserBookmarksIllust extends Object {

  @JsonKey(name: 'illusts')
  List<CommonIllust> illusts;

  @JsonKey(name: 'next_url')
  String nextUrl;

  UserBookmarksIllust(this.illusts,this.nextUrl,);

  factory UserBookmarksIllust.fromJson(Map<String, dynamic> srcJson) => _$UserBookmarksIllustFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserBookmarksIllustToJson(this);

}


