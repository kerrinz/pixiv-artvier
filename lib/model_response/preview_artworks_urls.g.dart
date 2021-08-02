// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_artworks_urls.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreviewArtworksUrls _$PreviewArtworksUrlsFromJson(Map<String, dynamic> json) {
  return PreviewArtworksUrls(
    json['square_medium'] as String,
    json['medium'] as String,
    json['large'] as String,
    json['original'] as String?,
  );
}

Map<String, dynamic> _$PreviewArtworksUrlsToJson(
        PreviewArtworksUrls instance) =>
    <String, dynamic>{
      'square_medium': instance.squareMedium,
      'medium': instance.medium,
      'large': instance.large,
      'original': instance.original,
    };
