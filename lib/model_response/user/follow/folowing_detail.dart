import 'package:json_annotation/json_annotation.dart'; 
      
part 'folowing_detail.g.dart';
    
@JsonSerializable(explicitToJson: true)
class TheFollowingDetail{

  @JsonKey(name: 'follow_detail')
  UserFollowingDetail? detail;

  TheFollowingDetail();

  static TheFollowingDetail fromJson(Map<String, dynamic> srcJson) => _$TheFollowingDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TheFollowingDetailToJson(this);

}

  
@JsonSerializable(explicitToJson: true)
class UserFollowingDetail{

  @JsonKey(name: 'is_followed')
  bool? isFollowed;

  @JsonKey(name: 'restrict')
  String? restrict;

  UserFollowingDetail({this.isFollowed,this.restrict});

  static UserFollowingDetail fromJson(Map<String, dynamic> srcJson) => _$UserFollowingDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserFollowingDetailToJson(this);

}