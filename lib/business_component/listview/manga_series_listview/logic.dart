import 'package:artvier/model_response/manga/manga_series_list.dart';
import 'package:artvier/pages/artwork/series/model/arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/routes.dart';

mixin ManagaSeriesListViewLogic {
  WidgetRef get ref;

  void handleTapItem(MangaSeries mangaSeries) {
    Navigator.of(ref.context).pushNamed(
      RouteNames.mangaSeriesDetail.name,
      arguments: MangaSeriesDetailPagePageArguments(
        id: mangaSeries.id,
        title: mangaSeries.title,
        url: mangaSeries.url,
        user: mangaSeries.user,
      ),
    );
  }
}
