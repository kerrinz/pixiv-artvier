import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_tag.freezed.dart';
part 'common_tag.g.dart';

@freezed
class CommonTag with _$CommonTag {
  const factory CommonTag({
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "translated_name") String? translatedName,
  }) = _CommonTag;

  factory CommonTag.fromJson(Map<String, dynamic> json) => _$CommonTagFromJson(json);
}
