import 'package:artvier/business_component/listview/novel_listview/novel_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/ranking/provider/ranking_provider.dart';

class RankingIllustTabPage extends BaseStatefulPage {
  const RankingIllustTabPage({
    super.key,
    required this.mode,
  });

  final String mode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RankingIllustTabPageState();
}

class _RankingIllustTabPageState extends BasePageState<RankingIllustTabPage> with AutomaticKeepAliveClientMixin {
  String get mode => widget.mode;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => ref.read(illustRankingProvier(mode).notifier).refresh(),
      child: Consumer(
        builder: (context, ref, child) {
          var asyncList = ref.watch(illustRankingProvier(mode));
          return asyncList.when(
            loading: () => const RequestLoading(),
            error: (Object error, StackTrace stackTrace) => RequestLoadingFailed(
              onRetry: () => ref.read(illustRankingProvier(mode).notifier).reload(),
            ),
            data: (List<CommonIllust> data) {
              return IllustWaterfallGridView(
                artworkList: data,
                onLazyload: () async => ref.read(illustRankingProvier(mode).notifier).next(),
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

class RankingMangaTabPage extends BaseStatefulPage {
  const RankingMangaTabPage({
    super.key,
    required this.mode,
  });

  final String mode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RankingMangaTabPageState();
}

class _RankingMangaTabPageState extends BasePageState<RankingMangaTabPage> with AutomaticKeepAliveClientMixin {
  String get mode => widget.mode;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => ref.read(mangaRankingProvier(mode).notifier).refresh(),
      child: Consumer(
        builder: (context, ref, child) {
          var asyncList = ref.watch(mangaRankingProvier(mode));
          return asyncList.when(
            loading: () => const RequestLoading(),
            error: (Object error, StackTrace stackTrace) => RequestLoadingFailed(
              onRetry: () => ref.read(mangaRankingProvier(mode).notifier).reload(),
            ),
            data: (List<CommonIllust> data) {
              return IllustWaterfallGridView(
                artworkList: data,
                onLazyload: () async => ref.read(mangaRankingProvier(mode).notifier).next(),
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

class RankingNovelTabPage extends BaseStatefulPage {
  const RankingNovelTabPage({
    super.key,
    required this.mode,
  });

  final String mode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RankingNovelTabPageState();
}

class _RankingNovelTabPageState extends BasePageState<RankingNovelTabPage> with AutomaticKeepAliveClientMixin {
  String get mode => widget.mode;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async => ref.read(novelRankingProvier(mode).notifier).refresh(),
      child: Consumer(
        builder: (context, ref, child) {
          var asyncList = ref.watch(novelRankingProvier(mode));
          return asyncList.when(
            loading: () => const RequestLoading(),
            error: (Object error, StackTrace stackTrace) => RequestLoadingFailed(
              onRetry: () => ref.read(novelRankingProvier(mode).notifier).reload(),
            ),
            data: (data) {
              return NovelListView(
                novelList: data,
                onLazyload: () async => ref.read(novelRankingProvier(mode).notifier).next(),
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
