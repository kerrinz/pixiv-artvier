import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/lazyload_logic_mixin.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/user/bookmark/bookmark_tag.dart';
import 'package:artvier/pages/user/collection/provider/filter_provider.dart';
import 'package:artvier/pages/user/collection/widget/tag_list_item.dart';

/// 标签列表
/// - 默认为非静态组件！
/// - 全权负责管理懒加载的状态，其他状态不在范围内。
/// - 请不要为 [onLazyload] 捕获异常，否则会导致懒加载区域无法显示 errorWidget
class TagListView extends ConsumerWidget with LazyloadLogic {
  /// 插画（或漫画）列表
  final List<BookmarkTag> tagList;

  /// 懒加载异步事件
  /// - return bool of hasMore. 需要返回是否还有更多数据
  /// - 当[lazyloadState] = [LazyloadState.loading]/[LazyloadState.noMore] 时**不会执行**此函数
  @override
  final Future<bool> Function() onLazyload;

  /// 赋值后本组件将不再负责懒加载状态，转变为静态组件
  final LazyloadState? lazyloadState;

  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  TagListView({
    super.key,
    required this.tagList,
    required this.onLazyload,
    this.lazyloadState,
    this.scrollController,
    this.physics,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: padding,
      controller: scrollController,
      physics: physics,
      itemBuilder: ((context, index) => itemBuilder(ref, index)),
      itemCount: tagList.length + 1,
    );
  }

  Widget itemBuilder(WidgetRef ref, index) {
    // 如果滑动到了表尾加载更多的项
    if (index == tagList.length) {
      handleViewLazyloadWidget(ref, onLazyload);
      // 尾部懒加载组件
      return lazyloadWidget(ref);
    }
    var tag = tagList[index];
    return TagListItemWidget(
      count: tag.count,
      isActived: tag.name == ref.watch(cachedCollectionsFilterProvider).tag,
      name: (tag.name?.isEmpty ?? false) ? "未分類" : tag.name ?? "全部",
      onTap: () => ref.read(cachedCollectionsFilterProvider.notifier).update(
            (state) => state.copyWith(tag: tag.name),
          ),
    );
  }

  /// 懒加载组件的构建
  Widget lazyloadWidget(WidgetRef ref) => Consumer(
        builder: ((context, ref, _) {
          var lazyloadState = ref.watch(lazyloadStateProvider);
          Map<LazyloadState, Widget> map = {
            LazyloadState.idle: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CircularProgressIndicator(strokeWidth: 1.0),
            ),
            LazyloadState.loading: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CircularProgressIndicator(strokeWidth: 1.0),
            ),
            LazyloadState.noMore: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text("没有更多了", style: TextStyle(color: Colors.grey)),
            ),
            LazyloadState.error: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: LazyloadingFailedWidget(
                onRetry: () => handleRetry(ref),
              ),
            ),
          };
          return SafeArea(left: true, top: false, right: true, bottom: true, child: map[lazyloadState]!);
        }),
      );
}

/// See [TagListView].
class SliverTagListView extends TagListView {
  SliverTagListView({
    super.key,
    required super.tagList,
    required super.onLazyload,
    super.lazyloadState,
    super.scrollController,
    super.physics,
    super.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => itemBuilder(ref, index),
        ),
      ),
    );
  }
}
