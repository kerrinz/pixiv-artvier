import 'package:json_annotation/json_annotation.dart';

import 'common_illust.dart';

part 'illust_trending_tags.g.dart';


@JsonSerializable()
class IllustTrendingTags extends Object {

  @JsonKey(name: 'trend_tags')
  List<TrendTags> trendTags;

  IllustTrendingTags(this.trendTags,);

  factory IllustTrendingTags.fromJson(Map<String, dynamic> srcJson) => _$IllustTrendingTagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IllustTrendingTagsToJson(this);

}

@JsonSerializable()
class TrendTags extends Object {

  @JsonKey(name: 'tag')
  String tag;

  @JsonKey(name: 'translated_name')
  String? translatedName;

  @JsonKey(name: 'illust')
  CommonIllust illust;

  TrendTags(this.tag,this.translatedName,this.illust,);

  factory TrendTags.fromJson(Map<String, dynamic> srcJson) => _$TrendTagsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TrendTagsToJson(this);

}