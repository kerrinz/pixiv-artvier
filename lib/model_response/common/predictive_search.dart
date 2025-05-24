// To parse this JSON data, do
//
//     final predictiveSearchWorks = predictiveSearchWorksFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'predictive_search.freezed.dart';
part 'predictive_search.g.dart';

PredictiveSearchWorks predictiveSearchWorksFromJson(String str) => PredictiveSearchWorks.fromJson(json.decode(str));

String predictiveSearchWorksToJson(PredictiveSearchWorks data) => json.encode(data.toJson());

@freezed
class PredictiveSearchWorks with _$PredictiveSearchWorks {
    const factory PredictiveSearchWorks({
        @JsonKey(name: "tags")
        required List<PredictiveSearchWorksTag> tags,
    }) = _PredictiveSearchWorks;

    factory PredictiveSearchWorks.fromJson(Map<String, dynamic> json) => _$PredictiveSearchWorksFromJson(json);
}

@freezed
class PredictiveSearchWorksTag with _$PredictiveSearchWorksTag {
    const factory PredictiveSearchWorksTag({
        @JsonKey(name: "name")
        required String name,
        @JsonKey(name: "translated_name")
        String? translatedName,
    }) = _PredictiveSearchWorksTag;

    factory PredictiveSearchWorksTag.fromJson(Map<String, dynamic> json) => _$PredictiveSearchWorksTagFromJson(json);
}
