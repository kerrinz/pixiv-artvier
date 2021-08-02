import 'package:json_annotation/json_annotation.dart';

part 'illust_comments.g.dart';


@JsonSerializable()
class IllustComments extends Object {

  @JsonKey(name: 'comments')
  List<Comments> comments;

  @JsonKey(name: 'next_url')
  String? nextUrl;

  IllustComments(this.comments,this.nextUrl,);

  factory IllustComments.fromJson(Map<String, dynamic> srcJson) => _$IllustCommentsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IllustCommentsToJson(this);

}


@JsonSerializable()
class Comments extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'comment')
  String comment;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'user')
  User user;

  @JsonKey(name: 'has_replies')
  bool hasReplies;

  Comments(this.id,this.comment,this.date,this.user,this.hasReplies,);

  factory Comments.fromJson(Map<String, dynamic> srcJson) => _$CommentsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);

}


@JsonSerializable()
class User extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'account')
  String account;

  @JsonKey(name: 'profile_image_urls')
  Profile_image_urls profileImageUrls;

  User(this.id,this.name,this.account,this.profileImageUrls,);

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}


@JsonSerializable()
class Profile_image_urls extends Object {

  @JsonKey(name: 'medium')
  String medium;

  Profile_image_urls(this.medium,);

  factory Profile_image_urls.fromJson(Map<String, dynamic> srcJson) => _$Profile_image_urlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Profile_image_urlsToJson(this);

}


