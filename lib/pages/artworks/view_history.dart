import 'package:flutter/material.dart';
import 'package:pixgem/common_providers/illust_list_provider.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/store/history_store.dart';
import 'package:pixgem/widgets/base_provider_widget.dart';
import 'package:pixgem/widgets/illust_waterfall_grid.dart';

class ViewHistory extends StatelessWidget {
  final IllustWaterfallProvider _provider = IllustWaterfallProvider();
  final List<CommonIllust> list = [];
  @override
  Widget build(BuildContext context) {
    _provider.setList(HistoryStore.getHistoryIllust());
    return Scaffold(
      appBar: AppBar(
        title: Text("浏览历史"),
        actions: [
          // 清空的按钮
          TextButton(
            child: Text("清空"),
            onPressed: () {
              showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("提示"),
                    content: Text("确定要清空所有历史记录吗?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("取消"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text("确定"),
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
        ],
      ),
      body: Container(
        child: ProviderWidget<IllustWaterfallProvider>(
          model: _provider,
          builder: (BuildContext context, IllustWaterfallProvider value, Widget? child) {
            return IllustWaterfallGrid(
              artworkList: value.list,
              onLazyLoad: () {},
            );
          },
        ),
      ),
    );
  }
}
