import 'package:flutter/material.dart';
import 'package:pixgem/provider/common_illusts.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/store/history_store.dart';
import 'package:pixgem/widgets/base_provider_widget.dart';
import 'package:pixgem/widgets/illust_waterfall_grid.dart';

class ViewHistory extends StatelessWidget {
  final IllustWaterfallProvider _provider = IllustWaterfallProvider();
  final List<CommonIllust> list = [];
  final ScrollController scrollController = ScrollController();

  ViewHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _provider.setList(HistoryStore.getHistoryIllust());
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
                        child: const Text("取消"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: const Text("确定"),
                        onPressed: () {
                          HistoryStore.clearIllusts().then((value) => _provider.clearList());
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_up),
            onPressed: () {
              scrollController.animateTo(
                0,
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate,
              );
            },
            tooltip: "回到顶部",
          ),
        ],
      ),
      body: ProviderWidget<IllustWaterfallProvider>(
        model: _provider,
        builder: (BuildContext context, IllustWaterfallProvider value, Widget? child) {
          return IllustWaterfallGrid(
            artworkList: value.list ?? [],
            scrollController: scrollController,
            onLazyLoad: () {},
          );
        },
      ),
    );
  }
}
