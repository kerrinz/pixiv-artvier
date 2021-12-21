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
    list.addAll(HistoryStore.getHistoryIllust());
    return Scaffold(
      appBar: AppBar(
        title: Text("浏览历史"),
        actions: [
          TextButton(onPressed: (){}, child: Text("清空")),
        ],
      ),
      body: Container(
        child: ProviderWidget(
            model: _provider,
            child: StatefulBuilder(
              builder: (context, StateSetter setState) {
                return IllustWaterfallGrid(
                  artworkList: list,
                  onLazyLoad: () {},
                );
              },
            )),
      ),
    );
  }
}
