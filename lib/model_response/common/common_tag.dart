import 'package:json_annotation/json_annotation.dart'; 
      
part 'common_tag.g.dart';
    

@JsonSerializable()
class CommonTag extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'translated_name')
  String? translatedName;

  CommonTag(this.name,this.translatedName,);

  factory CommonTag.fromJson(Map<String, dynamic> srcJson) => _$CommonTagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommonTagToJson(this);
}