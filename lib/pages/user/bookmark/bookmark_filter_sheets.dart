import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/component/bottom_sheet/slide_bar.dart';
import 'package:pixgem/component/filter/stateless_flow_filter.dart';
import 'package:pixgem/component/loading/lazyloading.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/user/bookmark/bookmark_tag.dart';
import 'package:pixgem/model_response/user/bookmark/bookmark_tag_list.dart';
import 'package:pixgem/pages/user/bookmark/bookmark_filter_model.dart';
import 'package:pixgem/pages/user/bookmark/bookmark_tags_provider.dart';
import 'package:provider/provider.dart';

/// 我的收藏页面的筛选弹窗
class BookmarkFilterSheet extends StatelessWidget {
  final FilterModel cacheModel;

  final BookmarkTagsProvider tagsProvider;

  final WorksType currentWorkType;

  final void Function(WorksType worksType, String restrict) requestBookmarkTags;

  const BookmarkFilterSheet({
    Key? key,
    required this.cacheModel,
    required this.tagsProvider,
    required this.currentWorkType,
    required this.requestBookmarkTags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ChangeNotifierProvider.value(
        value: tagsProvider,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetSlideBar(
              width: 48,
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            // 展示范围的选择
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("显示范围: ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
                Builder(builder: (filterContext) {
                  return StatelessTextFlowFilter(
                    initialIndexes: {cacheModel.restrict == CONSTANTS.restrict_public ? 0 : 1},
                    unselectedBackground: Theme.of(context).colorScheme.background,
                    spacing: 4,
                    onTap: (int tapIndex) {
                      cacheModel.setRestrict(tapIndex == 0 ? CONSTANTS.restrict_public : CONSTANTS.restrict_private);
                      requestBookmarkTags(currentWorkType, cacheModel.restrict);
                      (filterContext as Element).markNeedsBuild();
                    },
                    texts: [
                      LocalizationIntl.of(context).public,
                      LocalizationIntl.of(context).private,
                    ],
                  );
                }),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text("收藏的标签", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            // 标签列表
            ScrollConfiguration(
              behavior: _CusBehavior(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.5,
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background.withAlpha(150),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Consumer(
                    builder: ((context, BookmarkTagsProvider provider, child) {
                      switch (provider.loadingStatus) {
                        case LoadingStatus.loading:
                          return const RequestLoading();
                        case LoadingStatus.failed:
                          return RequestLoadingFailed(onRetry: () {
                            requestBookmarkTags(provider.currentWorksType, cacheModel.restrict);
                          });
                        case LoadingStatus.success:
                      }
                      List<BookmarkTag> tags =
                          provider.currentWorksType == WorksType.novel ? provider.novelTags : provider.illustTags;
                      return ListView.builder(
                        itemCount: tags.length + 2,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          // 全部（默认选项）
                          if (index == 0) {
                            return _TagListItemWidget(
                              name: LocalizationIntl.of(context).all,
                              count: null,
                              isActived: cacheModel.tag == null,
                              onTap: () {
                                cacheModel.setTag(null);
                                (context as Element).markNeedsBuild();
                              },
                            );
                          } else if (index == tags.length + 1) {
                            // 表尾项，懒加载专用
                            onlazyload();
                            String? nextUrl = provider.currentWorksType == WorksType.novel
                                ? provider.novelNextUrl
                                : provider.illustNextUrl;
                            if (nextUrl == null) {
                              return _buildNoMoreWidget(context);
                            } else {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: LazyloadingWidget(),
                              );
                            }
                          }
                          // Tags
                          return _TagListItemWidget(
                            name: "#${tags[index - 1].name ?? 'unknown'}",
                            count: tags[index - 1].count ?? 0,
                            isActived: cacheModel.tag == tags[index - 1].name,
                            onTap: () {
                              cacheModel.setTag(tags[index - 1].name);
                              (context as Element).markNeedsBuild();
                            },
                          );
                        }),
                      );
                    }),
                  ),
                ),
              ),
            ),
            // 底部按钮
            SafeArea(
              child: Row(
                children: [
                  // 取消按钮
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 12, left: 0, right: 4),
                      child: CupertinoButton(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        onPressed: () {
                          Navigator.of(context).pop<FilterModel>(null);
                        },
                        child: Text(
                          LocalizationIntl.of(context).promptCancel,
                          style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                  ),
                  // 确定按钮
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 12, left: 4, right: 0),
                      child: CupertinoButton(
                        color: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        onPressed: () {
                          Navigator.of(context).pop<FilterModel>(cacheModel);
                          (context as Element).markNeedsBuild();
                        },
                        child: Text(
                          LocalizationIntl.of(context).promptConform,
                          style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onlazyload() {
    String? nextUrl =
        tagsProvider.currentWorksType == WorksType.novel ? tagsProvider.novelNextUrl : tagsProvider.illustNextUrl;
    if (nextUrl == null) return;
    ApiBase().getNextUrlData(nextUrl: nextUrl).then((value) {
      BookmarkTagList list = BookmarkTagList.fromJson(value);
      tagsProvider.appendIllustTags(list.bookmarkTags ?? [], list.nextUrl);
    });
  }

  Widget _buildNoMoreWidget(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Center(child: Text("没有更多了")),
    );
  }
}

/// 去除Android设备滚动到边界后的动画效果
class _CusBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    if (Platform.isAndroid || Platform.isFuchsia) return child;
    return super.buildOverscrollIndicator(context, child, details);
  }
}

class _TagListItemWidget extends StatelessWidget {
  final String name;
  final int? count;
  final bool isActived;
  final void Function() onTap;

  const _TagListItemWidget({
    required this.name,
    required this.count,
    required this.isActived,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      child: Material(
        shadowColor: Colors.transparent,
        color: isActived ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(color: isActived ? Theme.of(context).colorScheme.primary : Colors.transparent),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: isActived
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
