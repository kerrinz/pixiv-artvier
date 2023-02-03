import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/everybody_newest_provider.dart';
import 'package:artvier/pages/main_navigation_tab_page/newest/provider/followed_newest_provider.dart';

class EverybodyNewestTabPage extends BaseStatefulPage {
  const EverybodyNewestTabPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EverybodyNewestTabPageState();
}

class _EverybodyNewestTabPageState extends BasePageState<EverybodyNewestTabPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => ref.read(everybodyNewestIllustsProvider.notifier).refresh(),
      child: Consumer(
        builder: (context, value, child) {
          var list = ref.watch(everybodyNewestIllustsProvider);
          return list.when(
            loading: () => const RequestLoading(),
            error: (Object error, StackTrace stackTrace) => RequestLoadingFailed(
              onRetry: () async => ref.read(everybodyNewestIllustsProvider.notifier).reload(),
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
