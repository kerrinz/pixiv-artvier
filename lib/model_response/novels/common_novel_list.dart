import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';

part 'common_novel_list.g.dart';


@JsonSerializable()
class CommonNovelList extends Object {

  @JsonKey(name: 'novels')
  List<CommonNovel> novels;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  CommonNovelList(this.novels, this.nextUrl);

  factory CommonNovelList.fromJson(Map<String, dynamic> srcJson) => _$CommonNovelListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonNovelListToJson(this);

}
