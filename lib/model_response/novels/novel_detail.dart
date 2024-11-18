import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'novel_detail.g.dart';

@JsonSerializable()
class NovelDetail extends Object {
  @JsonKey(name: 'novel')
  CommonNovel novel;

  NovelDetail(this.novel);

  factory NovelDetail.fromJson(Map<String, dynamic> srcJson) => _$NovelDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NovelDetailToJson(this);
}
