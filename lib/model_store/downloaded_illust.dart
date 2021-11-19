import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'downloaded_illust.g.dart';

@JsonSerializable()
class DownloadedIllust extends Object {
  /*
  * List<String> to List<DownloadedIllust>
  * */
  static List<DownloadedIllust> downloadedIllustStringListToItemList(List<String>? list) {
    if (list == null) return [];
    var listNew = <DownloadedIllust>[];
    list.forEach((element) {
      listNew.add(DownloadedIllust.fromJson(jsonDecode(element)));
    });
    return listNew;
  }

  /*
  * List<DownloadedIllust> to List<String>
  * */
  static List<String> downloadedIllustItemListToStringList(List<DownloadedIllust>? list) {
    if (list == null) return [];
    var listNew = <String>[];
    list.forEach((element) {
      listNew.add(jsonEncode(element.toJson()));
    });
    return listNew;
  }

  /*
  * 获取List类型下载插画集合，值已经实例化
  * */
  static List<DownloadedIllust> downloadedIllustStringToList(String jsonStr) {
    List<dynamic> list = json.decode(jsonStr);
    List<DownloadedIllust> result = <DownloadedIllust>[];
    list.forEach((value) {
      DownloadedIllust illust = DownloadedIllust.fromJson(value);
      result.add(illust);
    });
    return result;
  }

  /*
  * 获取String类型下载插画集合
  * */
  static String downloadedIllustsListToString(List<DownloadedIllust> list) {
    return json.encode(list);
  }

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'page_count')
  int pageCount;

  DownloadedIllust(
    this.id,
    this.title,
    this.type,
    this.pageCount,
  );

  factory DownloadedIllust.fromJson(Map<String, dynamic> srcJson) => _$DownloadedIllustFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DownloadedIllustToJson(this);
}
