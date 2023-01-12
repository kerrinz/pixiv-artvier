import 'package:json_annotation/json_annotation.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';

part 'downloading_illust.g.dart';

@JsonSerializable()
class DownloadingIllust extends Object {
  @JsonKey(name: 'illust')
  CommonIllust illust;

  @JsonKey(name: 'percentage')
  double percentage;

  @JsonKey(name: 'status')
  DownloadingStatus status;

  DownloadingIllust(
    this.illust,
    this.percentage,
    this.status,
  );

  factory DownloadingIllust.fromJson(Map<String, dynamic> srcJson) => _$DownloadingIllustFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DownloadingIllustToJson(this);
}

enum DownloadingStatus {
  downloading,
  pause,
  failed,
}
