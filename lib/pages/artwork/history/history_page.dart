import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/illust_listview/illust_waterfall_gridview.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/artwork/history/logic.dart';
import 'package:artvier/pages/artwork/history/provider/history_provider.dart';

class ViewHistoryPage extends BaseStatefulPage {
  const ViewHistoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends BasePageState<ViewHistoryPage> with HistoryPageLogic {
  late ScrollController scrollController;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController = PrimaryScrollController.of(context) ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("浏览历史"),
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
      body: Consumer(
        builder: (_, ref, __) {
          var list = ref.watch(historyArtworksProvider);
          return IllustWaterfallGridView(
            artworkList: list,
            scrollController: scrollController,
            onLazyload: () async => handleLazyload(),
          );
        },
      ),
    );
  }
}
