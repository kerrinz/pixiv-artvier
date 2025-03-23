// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'illust_comment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IllustCommentResponse _$IllustCommentResponseFromJson(
        Map<String, dynamic> json) =>
    IllustCommentResponse(
      Comments.fromJson(json['comment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IllustCommentResponseToJson(
        IllustCommentResponse instance) =>
    <String, dynamic>{
      'comment': instance.comment,
    };
