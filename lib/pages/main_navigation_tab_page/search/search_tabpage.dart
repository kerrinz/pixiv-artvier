import 'package:artvier/business_component/input/search_input.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/trending_tags_grid.dart';
import 'package:artvier/pages/main_navigation_tab_page/search/provider/trend_tags_provider.dart';

class SearchTabPage extends BaseStatefulPage {
  const SearchTabPage({super.key});

  @override
  BasePageState<BaseStatefulPage> createState() {
    return SearchTabPageState();
  }
}

class SearchTabPageState extends BasePageState<SearchTabPage> with AutomaticKeepAliveClientMixin {
  late final TextEditingController _textController;

  late final FocusNode _focusNode;

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.unfocus();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedNestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: SliverWidgetPersistentHeaderDelegate(
              maxHeight:
                  (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.of(context).padding.top,
              minHeight:
                  (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.of(context).padding.top,
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 10, left: 10, right: 10),
                color: colorScheme.surface,
                child: const SearchBox(),
              ),
            ),
          ),
        ];
      },
      // 内容主体
      body: RefreshIndicator(
        onRefresh: () async => ref.read(artworkTrendTagsProvider.notifier).refresh(),
        child: Consumer(
          builder: (_, ref, __) {
            var data = ref.watch(artworkTrendTagsProvider);
            return data.when(
              data: (data) => TrendingTagsGrid(
                tags: data,
              ),
              error: (error, stackTrace) => RequestLoadingFailed(
                onRetry: () => ref.read(artworkTrendTagsProvider.notifier).reload(),
              ),
              loading: () => const RequestLoading(),
            );
          },
        ),
      ),
    );
  }
}
