import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/user/bookmark/bookmark_tag.dart'; 
      
part 'bookmark_tag_list.g.dart';
    
@JsonSerializable(explicitToJson: true)
class BookmarkTagList{

  @JsonKey(name: 'bookmark_tags')
  List<BookmarkTag>? bookmarkTags;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  BookmarkTagList(this.bookmarkTags, this.nextUrl);

  static BookmarkTagList fromJson(Map<String, dynamic> srcJson) => _$BookmarkTagListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BookmarkTagListToJson(this);

}
