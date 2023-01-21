import 'dart:io';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/base/base_page.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/component/trending_tags_grid.dart';
import 'package:pixgem/pages/main_navigation_tab_page/search/provider/search_input_provider.dart';
import 'package:pixgem/pages/main_navigation_tab_page/search/provider/trend_tags_provider.dart';
import 'package:pixgem/routes.dart';

class SearchTabPage extends BaseStatefulPage {
  const SearchTabPage({Key? key}) : super(key: key);

  @override
  BasePageState<BaseStatefulPage> createState() {
    return SearchTabPageState();
  }
}

class SearchTabPageState extends BasePageState<SearchTabPage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late final TextEditingController _textController;

  late final FocusNode _focusNode;

  /// 键盘是否激活状态
  bool isKeyboardActived = false;

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // 失去焦点时标记
        isKeyboardActived = false;
      }
    });
    // 监听界面高度变化
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // 页面高度变化（键盘收起或弹出）时
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Platform.isAndroid && _focusNode.hasFocus) {
        if (isKeyboardActived) {
          // 使输入框失去焦点
          _focusNode.unfocus();
        }
        isKeyboardActived = !isKeyboardActived;
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.unfocus();
    _focusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedNestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            title: _buildSearchBox(context),
            toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
            actions: <Widget>[
              IconButton(
                icon: const Text("取消"),
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
      body: RefreshIndicator(
        onRefresh: () async => ref.read,
        child: Consumer(
          builder: (_, ref, __) {
            var data = ref.watch(artworkTrendTagsProvider);
            return data.when(
              data: (data) => TrendingTagsGrid(
                tags: data,
              ),
              error: (error, stackTrace) => RequestLoadingFailed(
                onRetry: () => ref.read(artworkTrendTagsProvider.notifier).retry(),
              ),
              loading: () => const RequestLoading(),
            );
          },
        ),
      ),
    );
  }

  // 构建搜索框
  Widget _buildSearchBox(BuildContext context) {
    return Container(
      // 搜索框
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.15), borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        children: [
          // 框左边的搜索图标
          const Padding(
            padding: EdgeInsets.only(left: 10.0, right: 4),
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
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: "搜索...",
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isCollapsed: true, // 高度包裹，不会存在默认高度
              ),
              onSubmitted: (value) {
                // 跳转搜索结果页面
                Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: value);
              },
              onChanged: (value) => ref.read(searchInputProvider.notifier).update((state) => value),
            ),
          ),
          // 清空按钮
          Consumer(
            builder: (_, ref, __) {
              String text = ref.watch(searchInputProvider);
              if (text.isEmpty) {
                return Container();
              }
              return InkWell(
                child: const SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(Icons.clear, size: 18),
                ),
                onTap: () {
                  _textController.clear();
                  ref.read(searchInputProvider.notifier).update((state) => "");
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
