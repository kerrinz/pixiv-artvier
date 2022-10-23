import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/illusts_provider.dart';
import 'package:pixgem/component/base_provider_widget.dart';
import 'package:pixgem/component/scroll_list/illust_waterfall_grid.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/store/history_store.dart';

class ViewHistoryPage extends StatefulWidget {
  const ViewHistoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<ViewHistoryPage> {
  final IllustListProvider _provider = IllustListProvider();
  final List<CommonIllust> list = [];
  late ScrollController scrollController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController = PrimaryScrollController.of(context) ?? ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    _provider.resetIllusts(HistoryStore.getHistoryIllust(), null);
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
                        child: Text(LocalizationIntl.of(context).promptConform),
                        onPressed: () {
                          HistoryStore.clearIllusts().then((value) => _provider.clearIllusts());
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: ProviderWidget<IllustListProvider>(
        model: _provider,
        builder: (BuildContext context, IllustListProvider value, Widget? child) {
          return IllustWaterfallGrid(
            artworkList: value.list,
            scrollController: scrollController,
            hasMore: false,
            onLazyLoad: () {},
          );
        },
      ),
    );
  }
}
