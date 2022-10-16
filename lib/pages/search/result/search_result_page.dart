import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/common_provider/list_loadmore_provider.dart';
import 'package:pixgem/component/scroll_list/illust_waterfall_grid.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/illusts_search_result.dart';
import 'package:pixgem/api_app/api_serach.dart';
import 'package:provider/provider.dart';

class SearchResultPage extends StatefulWidget {
  late final String label; // 搜索文本内容

  SearchResultPage(Object arguments, {Key? key}) : super(key: key) {
    label = arguments as String;
  }

  @override
  State<StatefulWidget> createState() => SearchResultPageState();
}

class SearchResultPageState extends State<SearchResultPage> {
  late TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();
  final ListLoadmoreProvider<CommonIllust> _provider = ListLoadmoreProvider<CommonIllust>();
  List<String> bookmarkLevels = const [
    "0",
    "500",
    "1000",
    "5000",
    "10000",
    "20000",
  ]; // 插画的收藏级别
  int selectedLevelsIndex = 0; // 选择的收藏级别的索引

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.label);
    refresh()
        .catchError((onError) => Fluttertoast.showToast(msg: "加载失败!", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
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
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              autofocus: false,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: "搜索...",
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true, // 高度包裹，不会存在默认高度
              ),
              onSubmitted: (value) async {
                // 提交搜索
                await refresh().catchError((onError) =>
                    Fluttertoast.showToast(msg: "加载失败!$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
              },
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                _focusNode.unfocus();
                showGeneralDialog<int>(
                  context: context,
                  pageBuilder:
                      (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                    return Scaffold(
                      backgroundColor: Colors.black26, // 遮罩层
                      body: Stack(
                        children: [
                          GestureDetector(onTap: () => Navigator.of(context).pop()),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).dialogBackgroundColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                              ),
                              child: Column(
                                children: [
                                  Builder(
                                    builder: (context) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            width: double.infinity,
                                            child: Text("收藏超过${bookmarkLevels[selectedLevelsIndex]}的插画"),
                                          ),
                                          Slider(
                                            min: 0,
                                            max: bookmarkLevels.length.roundToDouble() - 1,
                                            label: bookmarkLevels[selectedLevelsIndex],
                                            onChanged: (double value) {
                                              selectedLevelsIndex = value.round();
                                              (context as Element).markNeedsBuild();
                                            },
                                            divisions: bookmarkLevels.length - 1,
                                            value: selectedLevelsIndex.roundToDouble(),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  // 取消按钮
                                  Container(
                                    width: double.infinity,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    padding: const EdgeInsets.only(top: 8),
                                    child: CupertinoButton(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.zero,
                                      child: Text(
                                        "确定",
                                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                      ),
                                      onPressed: () {
                                        _provider.clear();
                                        refresh(
                                            label:
                                                "${_textController.text} ${bookmarkLevels[selectedLevelsIndex]}users入り");
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              tooltip: "more",
            ),
          ],
        ),
        body: Selector(
          selector: (BuildContext context, ListLoadmoreProvider<CommonIllust> provider) {
            return provider.list;
          },
          builder: (BuildContext context, List<CommonIllust>? illusts, Widget? child) {
            if (illusts == null) {
              // loading
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(strokeWidth: 1.0, color: Theme.of(context).colorScheme.secondary),
              );
            } else if (illusts.isEmpty) {
              return Container(
                alignment: Alignment.center,
                child: const Text("无搜索结果", style: TextStyle(fontSize: 18)),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                return await refresh();
              },
              child: IllustWaterfallGrid(
                physics: const BouncingScrollPhysics(),
                artworkList: illusts,
                onLazyLoad: () async {
                  await loadMore().catchError((onError) =>
                      Fluttertoast.showToast(msg: "加载失败!", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future refresh({String? label}) async {
    var result = await ApiSearch().searchIllust(searchWord: label ?? _textController.value.text);
    _provider.setList(result.illusts);
    _provider.setNextUrl(result.nextUrl);
  }

  // 加载更多
  Future loadMore() async {
    if (_provider.nextUrl == null) return false;
    var res = await ApiSearch().getNextUrlData(nextUrl: _provider.nextUrl!);
    var result = IllustsSearchResult.fromJson(res);
    _provider.addAll(result.illusts);
    _provider.setNextUrl(result.nextUrl);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }
}
