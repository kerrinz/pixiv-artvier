/*
* 全屏预览图片时，所用的图片信息（包含链接和页码）
* */
import 'package:json_annotation/json_annotation.dart';

part 'preview_artworks_urls.g.dart';

@JsonSerializable()
class PreviewArtworksUrls extends Object {

  @JsonKey(name: 'square_medium')
  String squareMedium;

  @JsonKey(name: 'medium')
  String medium;

  @JsonKey(name: 'large')
  String large;

  @JsonKey(name: 'original')
  String? original;

  PreviewArtworksUrls(this.squareMedium,this.medium,this.large,this.original);

  PreviewArtworksUrls.create({required this.squareMedium,required this.medium,required this.large,required this.original});

  factory PreviewArtworksUrls.fromJson(Map<String, dynamic> srcJson) => _$PreviewArtworksUrlsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PreviewArtworksUrlsToJson(this);

}
