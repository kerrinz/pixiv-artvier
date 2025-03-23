import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/pages/artwork/detail/provider/illust_related_provider.dart';

/// 相关作品（插画漫画）
class RelatedArtworksContentWidget extends ConsumerWidget {
  const RelatedArtworksContentWidget({
    super.key,
    required this.worksId,
  });

  final String worksId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (_, ref, __) => ref.watch(illustRelatedProvider(worksId)).when(
            data: (data) => SliverIllustWaterfallGridView(
              artworkList: data,
              onLazyload: () async => ref.read(illustRelatedProvider(worksId).notifier).next(),
            ),
            error: (_, __) => SliverToBoxAdapter(
              child: RequestLoadingFailed(
                onRetry: () async => ref.read(illustRelatedProvider(worksId).notifier).reload(),
              ),
            ),
            loading: () => const SliverToBoxAdapter(child: RequestLoading()),
          ),
    );
  }
}
