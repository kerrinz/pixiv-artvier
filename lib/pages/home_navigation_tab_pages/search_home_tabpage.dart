import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/illust_trending_tags.dart';
import 'package:pixgem/request/api_app.dart';
import 'package:pixgem/widgets/trending_tags_gird.dart';
import 'package:provider/provider.dart';

class SearchTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchTabPageState();
  }
}

class SearchTabPageState extends State<SearchTabPage>
    with AutomaticKeepAliveClientMixin {
  _SearchProvider _provider = _SearchProvider();
  TextEditingController _textController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _provider,
      child: NestedScrollView(
        // controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              // floating: true,
              // snap: true,
              title: _buildSearchBBox(context),
              // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
              actions: <Widget>[
                IconButton(
                  icon: Text("取消"),
                  onPressed: () {
                    _focusNode.unfocus();
                  },
                  tooltip: "取消",
                ),
              ],
            )
          ];
        },
        // 内容主体
        body: Container(
          child: Selector(
            selector: (BuildContext context, _SearchProvider provider) {
              return provider.trendTags;
            },
            builder:
                (BuildContext context, List<TrendTags>? tags, Widget? child) {
              if (tags == null) {
                // loading
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(strokeWidth: 1.0, color: Theme.of(context).accentColor),
                );
              }
              return TrendingTagsGird(
                tags: tags,
              );
            },
          ),
        ),
      ),
    );
  }

  // 构建搜索框
  Widget _buildSearchBBox(BuildContext context) {
    return Container(
      // 搜索框
      height: 40,
      color: Colors.grey.withOpacity(0.12),
      child: Row(
        children: [
          // 框左边的搜索图标
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(Icons.search_outlined, size: 18),
          ),
          // 搜索框
          Expanded(
            flex: 1,
            child: TextField(
              autofocus: false,
              focusNode: _focusNode,
              controller: _textController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              // 键盘的回车键换成搜索按钮
              decoration: InputDecoration(
                hintText: "搜索...",
                contentPadding:
                EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true, // 高度包裹，不会存在默认高度
              ),
              onSubmitted: (value) {
                // 跳转搜索结果页面
                Navigator.of(context)
                    .pushNamed("search_result", arguments: value);
              },
              onChanged: (value) {
                if (value == "") {
                  _provider.setIsExistText(false);
                } else {
                  _provider.setIsExistText(true);
                }
              },
            ),
          ),
          // 清空按钮
          Selector(
            builder: (BuildContext context, bool isExistText,
                Widget? child) {
              if (!isExistText) {
                return Container();
              }
              return InkWell(
                child: Container(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.clear, size: 18),
                ),
                onTap: () {
                  _textController.clear();
                  _provider.setIsExistText(false);
                },
              );
            },
            selector: (context, _SearchProvider provider) {
              return provider.isExistText;
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // 获取热门标签
    requestTrendingTags();
  }

  Future requestTrendingTags() async {
    var resModel = await ApiApp().getTrendingTags();
    _provider.setTags(resModel.trendTags);
    return resModel;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }
}

class _SearchProvider with ChangeNotifier {
  List<TrendTags>? trendTags; // 热门标签
  bool isExistText = false; // 搜索框是否存在文字

  void setTags(List<TrendTags> tags) {
    this.trendTags = tags;
    notifyListeners();
  }

  void setIsExistText(bool isExist) {
    this.isExistText = isExist;
    notifyListeners();
  }
}
