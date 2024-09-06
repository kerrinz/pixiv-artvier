import 'package:json_annotation/json_annotation.dart';

part 'ugoira.g.dart';

@JsonSerializable(explicitToJson: true)
class UgoiraMetadataResult {
  @JsonKey(name: 'ugoira_metadata')
  UgoiraMetadata ugoiraMetadata;

  UgoiraMetadataResult(this.ugoiraMetadata);

  factory UgoiraMetadataResult.fromJson(Map<String, dynamic> json) => _$UgoiraMetadataResultFromJson(json);

  Map<String, dynamic> toJson() => _$UgoiraMetadataResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UgoiraMetadata {
  @JsonKey(name: 'zip_urls')
  ZipUrls zipUrls;
  List<Frame> frames;

  UgoiraMetadata(this.zipUrls, this.frames);

  factory UgoiraMetadata.fromJson(Map<String, dynamic> json) => _$UgoiraMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$UgoiraMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ZipUrls {
  String medium;

  ZipUrls(this.medium);

  factory ZipUrls.fromJson(Map<String, dynamic> json) => _$ZipUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$ZipUrlsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Frame {
  String file;
  int delay;

  Frame(this.file, this.delay);

  factory Frame.fromJson(Map<String, dynamic> json) => _$FrameFromJson(json);

  Map<String, dynamic> toJson() => _$FrameToJson(this);
}
