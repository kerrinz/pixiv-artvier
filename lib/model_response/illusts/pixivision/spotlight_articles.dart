import 'package:json_annotation/json_annotation.dart';

part 'spotlight_articles.g.dart';

@JsonSerializable()
class SpotlightArticles extends Object {
  @JsonKey(name: 'spotlight_articles')
  List<SpotlightArticle> spotlightArticles;

  @JsonKey(name: 'next_url')
  String nextUrl;

  SpotlightArticles(
    this.spotlightArticles,
    this.nextUrl,
  );

  factory SpotlightArticles.fromJson(Map<String, dynamic> srcJson) => _$SpotlightArticlesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SpotlightArticlesToJson(this);
}

@JsonSerializable()
class SpotlightArticle extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'pure_title')
  String pureTitle;

  @JsonKey(name: 'thumbnail')
  String thumbnail;

  @JsonKey(name: 'article_url')
  String articleUrl;

  @JsonKey(name: 'publish_date')
  String publishDate;

  @JsonKey(name: 'category')
  String category;

  @JsonKey(name: 'subcategory_label')
  String subcategoryLabel;

  SpotlightArticle(
    this.id,
    this.title,
    this.pureTitle,
    this.thumbnail,
    this.articleUrl,
    this.publishDate,
    this.category,
    this.subcategoryLabel,
  );

  factory SpotlightArticle.fromJson(Map<String, dynamic> srcJson) => _$SpotlightArticleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SpotlightArticleToJson(this);
}
