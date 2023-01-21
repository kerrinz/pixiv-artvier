import 'package:json_annotation/json_annotation.dart'; 
      
part 'collection_detail.g.dart';
    
@JsonSerializable(explicitToJson: true)
class TheCollectionDetail{

  @JsonKey(name: 'bookmark_detail')
  WorksCollectDetail? detail;

  TheCollectionDetail();

  static TheCollectionDetail fromJson(Map<String, dynamic> srcJson) => _$TheCollectionDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TheCollectionDetailToJson(this);

}

  
@JsonSerializable(explicitToJson: true)
class WorksCollectDetail{

  @JsonKey(name: 'is_bookmarked')
  bool? isBookmarked;

  @JsonKey(name: 'tags')
  List<WorksCollectTag>? tags;

  @JsonKey(name: 'restrict')
  String? restrict;

  WorksCollectDetail({this.isBookmarked,this.restrict,this.tags});

  static WorksCollectDetail fromJson(Map<String, dynamic> srcJson) => _$WorksCollectDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorksCollectDetailToJson(this);

}

  
@JsonSerializable(explicitToJson: true)
class WorksCollectTag{

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'is_registered')
  bool? isRegistered;

  WorksCollectTag({this.name, this.isRegistered});

  static WorksCollectTag fromJson(Map<String, dynamic> srcJson) => _$WorksCollectTagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WorksCollectTagToJson(this);

}