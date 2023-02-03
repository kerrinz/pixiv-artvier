import 'package:json_annotation/json_annotation.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';

part 'illusts_search_result.g.dart';


@JsonSerializable()
class IllustsSearchResult extends Object {

  @JsonKey(name: 'illusts')
  List<CommonIllust> illusts;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  @JsonKey(name: 'search_span_limit')
  int searchSpanLimit;

  IllustsSearchResult(this.illusts,this.nextUrl,this.searchSpanLimit,);

  factory IllustsSearchResult.fromJson(Map<String, dynamic> srcJson) => _$IllustsSearchResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IllustsSearchResultToJson(this);

}