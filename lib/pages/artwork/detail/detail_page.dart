import 'package:artvier/business_component/ugoira_image/ugoira_image.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/pages/artwork/detail/provider/illust_detail_provider.dart';
import 'package:artvier/pages/artwork/detail/widgets/menu_bottom_sheet.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/storage/viewing_history/viewing_history_db.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/drag_view/drag_vertical_container.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/viewport/delayed_build_until_viewport.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/pages/artwork/detail/layout.dart';
import 'package:artvier/pages/artwork/detail/logic.dart';
import 'package:artvier/pages/artwork/detail/widgets/comments_preview_content.dart';
import 'package:artvier/pages/artwork/detail/widgets/author_card.dart';
import 'package:artvier/pages/artwork/detail/widgets/related_artworks_content.dart';
import 'package:artvier/routes.dart';

class ArtWorksDetailPage extends ConsumerStatefulWidget {
  final IllustDetailPageArguments args; // 数据集

  const ArtWorksDetailPage(Object arguments, {super.key}) : args = arguments as IllustDetailPageArguments;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ArtWorksDetailState();
  }
}

class _ArtWorksDetailState extends ConsumerState<ArtWorksDetailPage>
    with TickerProviderStateMixin, ArtworkDetailPageLogic {
  late final TabController _tabController;

  late final DragController _dragController;

  @override
  get artworkDetail => widget.args.detail;

  @override
  get artworkId => widget.args.illustId;

  TextTheme get textTheme => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    _dragController = DragController();
    if (widget.args.detail != null) {
      viewingHistoryDatabase
          .addRecordWithRemoveDuplicates(ViewingHistoryTableData(
            title: widget.args.detail!.title,
            type: WorksType.illust,
            worksId: widget.args.detail!.id.toString(),
            previewImageUrl: widget.args.detail!.imageUrls.medium,
            authorName: widget.args.detail!.user.name,
            lastTime: DateTime.now(),
          ))
          // ignore: invalid_return_type_for_catch_error
          .catchError((err) => logger.e(err));
    }
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.args.detail != null) {
      CommonIllust detail = widget.args.detail!;
      return Scaffold(body: _buildSuccessContent(detail));
    } else {
      return Scaffold(
        body: ref.watch(illustDetailProvider(artworkId)).when(
              data: (data) => _buildSuccessContent(data!.illust),
              error: (obj, error) => RequestLoadingFailed(onRetry: () => ref.refresh(illustDetailProvider(artworkId))),
              loading: () => const RequestLoading(),
            ),
      );
    }
  }

  Widget _buildSuccessContent(CommonIllust detail) {
    return ArtworkDetailPageLayout(
        isShapedScreen: false,
        dragController: _dragController,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
          leading: AppbarBlurIconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            AppbarBlurIconButton(
              icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              onPressed: () {
                BottomSheets.showCustomBottomSheet<bool>(
                  context: ref.context,
                  exitOnClickModal: true,
                  enableDrag: false,
                  child: ArtworkDetailMenu(
                    detail: widget.args.detail ?? detail,
                  ),
                );
              },
            )
          ],
        ),
        viewerContent: _buildPreviewImages(detail),
        collectButton: _collectButton(),
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 1),
              child: BottomSheetSlideBar(width: 48, height: 3),
            ),
          ),
          // 作品标题吸顶
          SliverStickyHeader(
            // 作品的标题
            header: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
              color: colorScheme.surface,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(detail.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              ),
            ),
            // 概述信息
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  // 作者卡片
                  AuthorCardWidget(detail: detail, tabController: _tabController),
                  _buildInformation(detail),
                ],
              ),
            ),
          ),
          // 评论区域，吸顶
          SliverStickyHeader(
            // 评论的标题栏
            header: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              color: colorScheme.surface,
              child: Text("评论", style: textTheme.titleMedium),
            ),
            // 评论列表（预览部分）
            sliver: SliverToBoxAdapter(child: CommentsPreviewContentWidget(artworkId: artworkId)),
          ),
          // 相关作品区域，吸顶
          SliverStickyHeader(
            // 相关作品的标题栏
            header: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              color: colorScheme.surface,
              child: Text("相关作品", style: textTheme.titleMedium),
            ),
            // 相关作品列表
            sliver: SliverDelayedBuildUntilViewportWidget(
              placeholderWidget: const SliverToBoxAdapter(child: RequestLoading()),
              child: RelatedArtworksContentWidget(worksId: artworkId),
            ),
          ),
        ]);
  }

  Widget _buildPreviewImages(CommonIllust detail) {
    // 图片链接列表
    List<String> imageUrls = [];
    if (detail.metaPages.isEmpty) {
      imageUrls.add(detail.imageUrls.large);
    } else {
      for (var item in detail.metaPages) {
        imageUrls.add(item.imageUrls.large);
      }
    }
    return Center(
      child: ListView.builder(
        clipBehavior: Clip.none,
        shrinkWrap: true,
        padding: EdgeInsets.zero, // 去除预留的安全区
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        itemBuilder: ((context, index) {
          String url = imageUrls[index];
          Key? imgKey = Key(DateTime.now().millisecondsSinceEpoch.toString());
          return Stack(
            fit: StackFit.passthrough,
            children: [
              // 图片
              GestureDetector(
                onTap: () => handleTapImage(detail, imageUrls.indexOf(url)),
                child: EnhanceNetworkImage(
                  key: imgKey,
                  image: ExtendedNetworkImageProvider(
                    HttpHostOverrides().pxImgUrl(url),
                    headers: const {"referer": CONSTANTS.referer},
                    cache: true,
                  ),
                  // key: _imgKey,
                  errorWidget: (context, url, error) {
                    return LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          alignment: Alignment.center,
                          width: constraints.maxWidth,
                          height: detail.height / detail.width * constraints.maxWidth,
                          child: ElevatedButton(
                            onPressed: () {
                              (context as Element).markNeedsBuild();
                            },
                            child: const Text("加载失败，点击重试"),
                          ),
                        );
                      },
                    );
                  },
                  // 加载时显示loading图标
                  loadingWidget: (BuildContext context, String url, ImageChunkEvent process) {
                    return LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          alignment: Alignment.center,
                          width: constraints.maxWidth,
                          height: detail.height / detail.width * constraints.maxWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                // strokeWidth: 4.0,
                                value: process.progress,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text("${((process.progress ?? 0) * 100).toStringAsFixed(0)}%"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              // 动图
              if (detail.type == "ugoira")
                LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  return UgoiraImage(
                    size: Size(
                      constraints.maxWidth,
                      detail.height / detail.width * constraints.maxWidth,
                    ),
                    illustId: detail.id.toString(),
                  );
                })
            ],
          );
        }),
        itemCount: imageUrls.length,
      ),
    );
  }

  /// 收藏按钮
  Widget _collectButton() {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onLongPress: (() => handleLongTapCollect(ref)),
      child: InkWell(
        onTap: () => handleTapCollect(ref),
        child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              gradient: LinearGradient(colors: [
                colorScheme.surface,
                colorScheme.surface,
                colorScheme.surface,
                colorScheme.surface.withAlpha(0),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Consumer(builder: ((context, ref, child) {
              CollectState status = ref.watch(illustDetailCollectStateProvider);
              switch (status) {
                case CollectState.collecting:
                  return const Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: 28,
                  );
                case CollectState.uncollecting:
                  return Icon(
                    Icons.favorite,
                    color: Colors.red.shade200,
                    size: 28,
                  );
                case CollectState.collected:
                  return const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 28,
                  );
                case CollectState.notCollect:
                  return const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                    size: 28,
                  );
              }
            }))),
      ),
    );
  }

  Widget _buildInformation(CommonIllust detail) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: Row(
                children: [
                  // ID
                  Expanded(
                      flex: 1,
                      child: Text("id: ${detail.id}", style: textTheme.bodyMedium?.copyWith(color: Colors.grey))),
                  // 收藏数
                  Expanded(
                    flex: 1,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.favorite, size: 18, color: Colors.grey),
                      Text(" ${detail.totalBookmarks}", style: textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    ]),
                  ),
                  // 浏览数
                  Expanded(
                    flex: 1,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      const Icon(Icons.remove_red_eye, size: 18, color: Colors.grey),
                      Text(" ${detail.totalView}", style: textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                    ]),
                  ),
                ],
              )),
          // 简介，字段为comment
          Text(
            detail.caption,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 15),
          ),
          // 标签列的标题
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
            // color: colorScheme.surface,
            // child: Text("标签", style: textTheme.titleMedium),
          ),
          // 标签
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Wrap(
              spacing: 6,
              runSpacing: 8,
              children: [
                // 遍历Tag
                for (var element in detail.tags) _tagItemWidget(element.name, element.translatedName)
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 标签项
  Widget _tagItemWidget(String text, String? translateText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyBadge(
          color: colorScheme.primary.withAlpha(32),
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          onTap: () {
            Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: text);
          },
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "#$text ",
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        // 标签的翻译文字
        if (translateText != null) Text("$translateText  ", style: textTheme.bodySmall),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
