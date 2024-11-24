import 'package:artvier/model_response/novels/novel_series_list.dart';
import 'package:artvier/pages/novel/series/model/arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/routes.dart';

mixin ManagaSeriesListViewLogic {
  WidgetRef get ref;

  void handleTapItem(NovelSeries novelSeries) {
    Navigator.of(ref.context).pushNamed(
      RouteNames.novelSeriesDetail.name,
      arguments: NovelSeriesDetailPagePageArguments(
        id: novelSeries.id,
        title: novelSeries.title,
        url: novelSeries.url,
        user: novelSeries.user,
      ),
    );
  }
}
