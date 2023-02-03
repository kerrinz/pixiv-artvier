import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/user/collection/provider/artwork_collections_provider.dart';

class MyCollectArtworksTabPage extends ConsumerStatefulWidget {
  const MyCollectArtworksTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCollectArtworksTabPageState();
}

class _MyCollectArtworksTabPageState extends ConsumerState<MyCollectArtworksTabPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ref.watch(myArtworkCollectionsStateProvider).when(
          loading: () => const RequestLoading(),
          data: (List<CommonIllust> artworks) => IllustWaterfallGridView(
            artworkList: artworks,
            lazyloadState: LazyloadState.idle,
            onLazyload: () async => ref.read(myArtworkCollectionsStateProvider.notifier).next(),
          ),
          error: (_, __) => RequestLoadingFailed(
            onRetry: () async => ref.read(myArtworkCollectionsStateProvider.notifier).reload(),
          ),
        );
  }

  @override
  bool get wantKeepAlive => true;
}
