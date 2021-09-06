import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/request/api_app.dart';
import 'package:pixgem/widgets/illust_waterfall_gird.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatefulWidget {
  late String label; // 搜索文本内容

  SearchResultPage(Object arguments, {Key? key}) : super(key: key) {
    label = arguments as String;
  }

  @override
  State<StatefulWidget> createState() => SearchResultPageState();
}

class SearchResultPageState extends State<SearchResultPage> {
  late TextEditingController _textController;
  _SearchResultProvider _provider = _SearchResultProvider();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.label);
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            // height: 40,
            color: Colors.grey.withOpacity(0.1),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "搜索...",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true, // 高度包裹，不会存在默认高度
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
              tooltip: "more",
            ),
          ],
        ),
        body: Container(
          child: Selector(
            selector: (BuildContext context, _SearchResultProvider provider) {
              return provider.illusts;
            },
            builder: (BuildContext context, List<CommonIllust>? illusts,
                Widget? child) {
              if (illusts == null) {
                // loading
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(strokeWidth: 1.0),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  return await refresh();
                },
                child: IllustWaterfallGird(
                  artworkList: illusts,
                  onLazyLoad: () {

                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future refresh() async {
    var result = await ApiApp().searchIllust(searchWord: _textController.value.text);
    _provider.setIllusts(result.illusts);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }
}

class _SearchResultProvider with ChangeNotifier {
  List<CommonIllust>? illusts;

  void setIllusts(List<CommonIllust> illusts) {
    this.illusts = illusts;
    notifyListeners();
  }
}
