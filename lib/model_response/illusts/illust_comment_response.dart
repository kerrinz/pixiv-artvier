// ignore_for_file: camel_case_types

import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:json_annotation/json_annotation.dart';

part 'illust_comment_response.g.dart';

@JsonSerializable()
class IllustCommentResponse extends Object {
  @JsonKey(name: 'comment')
  Comments comment;

  IllustCommentResponse(this.comment);

  factory IllustCommentResponse.fromJson(Map<String, dynamic> srcJson) => _$IllustCommentResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IllustCommentResponseToJson(this);
}
