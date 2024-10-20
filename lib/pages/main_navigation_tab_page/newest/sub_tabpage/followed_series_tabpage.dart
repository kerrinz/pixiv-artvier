import 'package:artvier/business_component/listview/manga_series_listview/manga_series_listview.dart';
import 'package:artvier/model_response/manga/manga_series_list.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/followed_series_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/loading/request_loading.dart';

class FollowedSeriesTabPage extends BaseStatefulPage {
  const FollowedSeriesTabPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedSeriesTabPageState();
}

class _FollowedSeriesTabPageState extends BasePageState<FollowedSeriesTabPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => ref.read(followedMangeSeriesProvider.notifier).refresh(),
      child: Consumer(
        builder: (context, value, child) {
          var list = ref.watch(followedMangeSeriesProvider);
          return list.when(
            loading: () => const RequestLoading(),
            error: (Object error, StackTrace stackTrace) => RequestLoadingFailed(
              onRetry: () async => ref.read(followedMangeSeriesProvider.notifier).reload(),
            ),
            data: (List<MangaSeries> data) {
              return MangaSeriesListView(
                seriesList: data,
                onLazyload: () async => ref.read(followedMangeSeriesProvider.notifier).next(),
              );
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
