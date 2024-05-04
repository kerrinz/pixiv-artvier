import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/artwork/history/widgets/history_gridview.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/artwork/history/logic.dart';
import 'package:artvier/pages/artwork/history/provider/history_provider.dart';

class ViewHistoryPage extends BaseStatefulPage {
  const ViewHistoryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends BasePageState<ViewHistoryPage> with HistoryPageLogic {
  late ScrollController scrollController;
  @override
  void didChangeDependencies() {
    scrollController = PrimaryScrollController.of(context);
    ref.read(viewingHistoryProvider.notifier).reloadState();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        onlyOneScrollInBody: true,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              title: const Text("浏览历史"),
              toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
              actions: [
                // 清空的按钮
                TextButton(
                  child: const Text("清空"),
                  onPressed: () {
                    showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("提示"),
                          content: const Text("确定要清空所有历史记录吗?"),
                          actions: <Widget>[
                            TextButton(
                              child: Text(LocalizationIntl.of(context).promptCancel),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            TextButton(
                              onPressed: handleClearHistory,
                              child: Text(LocalizationIntl.of(context).promptConform),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ];
        },
        body: _buildIllustList(),
      ),
    );
  }

  // 构建图片列表
  Widget _buildIllustList() {
    var asyncValue = ref.watch(viewingHistoryProvider);
    return asyncValue.when(
      data: (itemList) {
        return HistoryGridView(
          itemList: itemList,
          scrollController: scrollController,
          lazyloadState: LazyloadState.noMore,
          onLazyload: () async => ref.read(viewingHistoryProvider.notifier).nextPage(),
        );
      },
      error: (error, stackTrace) => LazyloadingFailedWidget(
        onRetry: (() {
          /// TODO: 加载失败的界面
        }),
      ),
      loading: (() => const LazyloadingWidget()),
    );
  }
}
