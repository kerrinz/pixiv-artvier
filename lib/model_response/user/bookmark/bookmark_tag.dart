import 'package:json_annotation/json_annotation.dart';

part 'bookmark_tag.g.dart';

@JsonSerializable(explicitToJson: true)
class BookmarkTag {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'count')
  int? count;

  BookmarkTag({this.name, this.count});

  static BookmarkTag fromJson(Map<String, dynamic> srcJson) => _$BookmarkTagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookmarkTagToJson(this);
}
