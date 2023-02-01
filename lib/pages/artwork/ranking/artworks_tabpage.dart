import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/base/base_page.dart';
import 'package:pixgem/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/ranking/provider/artworks_ranking_provider.dart';

class ArtworksRankingTabPage extends BaseStatefulPage {
  const ArtworksRankingTabPage({
    super.key,
    required this.mode,
  });

  final String mode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ArtworksRankingTabPageState();
}

class _ArtworksRankingTabPageState extends BasePageState<ArtworksRankingTabPage> with AutomaticKeepAliveClientMixin {
  String get mode => widget.mode;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => ref.read(artworksRankingProvier(mode).notifier).refresh(),
      child: Consumer(
        builder: (context, value, child) {
          var asyncList = ref.watch(artworksRankingProvier(mode));
          return asyncList.when(
            loading: () => const RequestLoading(),
            error: (Object error, StackTrace stackTrace) => RequestLoadingFailed(
              onRetry: () => ref.read(artworksRankingProvier(mode).notifier).reload(),
            ),
            data: (List<CommonIllust> data) {
              return IllustWaterfallGridView(
                artworkList: data,
                onLazyload: () async => ref.read(artworksRankingProvier(mode).notifier).next(),
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
