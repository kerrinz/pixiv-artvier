import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/business_component/listview/novel_listview/novel_list.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/pages/user/collection/provider/artwork_collections_provider.dart';
import 'package:pixgem/pages/user/collection/provider/novel_collections_provider.dart';

class MyCollectNovelsTabPage extends ConsumerStatefulWidget {
  const MyCollectNovelsTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCollectNovelsTabPageState();
}

class _MyCollectNovelsTabPageState extends ConsumerState<MyCollectNovelsTabPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var state = ref.watch(myNovelCollectionsStateProvider);
    return state.when(
      loading: () => const RequestLoading(),
      data: (List<CommonNovel> list) => NovelListView(
        novelList: list,
        lazyloadState: LazyloadState.idle,
        onLazyload: () async => ref.read(myArtworkCollectionsStateProvider.notifier).next(),
      ),
      empty: () => const Center(
        child: Text("Empty."),
      ),
      error: (String error) => RequestLoadingFailed(
        onRetry: () async => ref.read(myArtworkCollectionsStateProvider.notifier).reload(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
