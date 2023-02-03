import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/followed_newest_provider.dart';

class FollowedNewestTabPage extends BaseStatefulPage {
  const FollowedNewestTabPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FollowedNewestTabPageState();
}

class _FollowedNewestTabPageState extends BasePageState<FollowedNewestTabPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => ref.read(followedNewestArtworksProvider.notifier).refresh(),
      child: Consumer(
        builder: (context, value, child) {
          var list = ref.watch(followedNewestArtworksProvider);
          return list.when(
            loading: () => const RequestLoading(),
            error: (Object error, StackTrace stackTrace) => RequestLoadingFailed(
              onRetry: () async => ref.read(followedNewestArtworksProvider.notifier).reload(),
            ),
            data: (List<CommonIllust> data) {
              return IllustWaterfallGridView(
                artworkList: data,
                onLazyload: () async => ref.read(followedNewestArtworksProvider.notifier).next(),
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
