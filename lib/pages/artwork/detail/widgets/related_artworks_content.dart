import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/artwork/detail/provider/illust_related_provider.dart';

/// 相关作品（插画漫画）
class RelatedArtworksContentWidget extends ConsumerWidget {
  RelatedArtworksContentWidget({
    super.key,
    required this.worksId,
  });

  final String worksId;

  /// 相关作品
  late final illustRelatedProvider = AutoDisposeAsyncNotifierProvider<RelatedArtworksNotifier, List<CommonIllust>>(() {
    return RelatedArtworksNotifier(worksId: worksId);
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (_, ref, __) {
      return ref.watch(illustRelatedProvider).when(
            data: (data) => SliverIllustWaterfallGridView(
              artworkList: data,
              onLazyload: () async => ref.read(illustRelatedProvider.notifier).next(),
            ),
            error: (_, __) => SliverToBoxAdapter(
              child: RequestLoadingFailed(onRetry: () async => ref.read(illustRelatedProvider.notifier).reload()),
            ),
            loading: () => const SliverToBoxAdapter(child: RequestLoading()),
          );
    });
  }
}
