// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'spotlight_articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpotlightArticles _$SpotlightArticlesFromJson(Map<String, dynamic> json) =>
    SpotlightArticles(
      (json['spotlight_articles'] as List<dynamic>)
          .map((e) => SpotlightArticle.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['next_url'] as String,
    );

Map<String, dynamic> _$SpotlightArticlesToJson(SpotlightArticles instance) =>
    <String, dynamic>{
      'spotlight_articles': instance.spotlightArticles,
      'next_url': instance.nextUrl,
    };

SpotlightArticle _$SpotlightArticleFromJson(Map<String, dynamic> json) =>
    SpotlightArticle(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['pure_title'] as String,
      json['thumbnail'] as String,
      json['article_url'] as String,
      json['publish_date'] as String,
      json['category'] as String,
      json['subcategory_label'] as String,
    );

Map<String, dynamic> _$SpotlightArticleToJson(SpotlightArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'pure_title': instance.pureTitle,
      'thumbnail': instance.thumbnail,
      'article_url': instance.articleUrl,
      'publish_date': instance.publishDate,
      'category': instance.category,
      'subcategory_label': instance.subcategoryLabel,
    };
