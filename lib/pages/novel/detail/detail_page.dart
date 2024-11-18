import 'package:artvier/business_component/card/author_card.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/layout/single_line_fitted_box.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/pages/novel/detail/layout.dart';
import 'package:artvier/pages/novel/detail/logic.dart';
import 'package:artvier/pages/novel/detail/provider/novel_detail_provider.dart';
import 'package:artvier/pages/novel/detail/widgets/menu_bottom_sheet.dart';
import 'package:artvier/storage/viewing_history/viewing_history_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/drag_view/drag_vertical_container.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/component/viewport/delayed_build_until_viewport.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/artwork/detail/widgets/related_artworks_content.dart';
import 'package:artvier/routes.dart';

class NovelDetailPage extends ConsumerStatefulWidget {
  final NovelDetailPageArguments args; // 数据集

  const NovelDetailPage(Object arguments, {super.key}) : args = arguments as NovelDetailPageArguments;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NovelDetailState();
  }
}

class _NovelDetailState extends ConsumerState<NovelDetailPage> with TickerProviderStateMixin, NovelDetailPageLogic {
  late final TabController _tabController;

  late final DragController _dragController;

  @override
  get novelDetail => widget.args.detail;

  @override
  get worksId => widget.args.worksId;

  TextTheme get textTheme => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  @override
  void initState() {
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
    final detail = widget.args.detail!;
    // final detailData = ref.watch(novelDetailProvider(worksId)).asData!.value!;
    return Scaffold(
      body: ref.watch(novelDetailWebViewProvider(worksId)).when(
            data: (data) => _buildSuccessContent(detail, data!),
            error: (obj, error) => _buildBeforeSuccessContent(true),
            loading: () => _buildBeforeSuccessContent(false),
          ),
    );
  }

  Widget _buildBeforeSuccessContent(bool isFailed) {
    return Stack(children: [
      AppBar(
        // backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: AppbarBlurIconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () {
            Navigator.pop(context);
          },
          background: Colors.transparent,
        ),
        title: SingleLineFittedBox(child: Text(widget.args.title ?? widget.args.worksId)),
      ),
      Builder(builder: (context) {
        if (isFailed) {
          return RequestLoadingFailed(onRetry: () => ref.refresh(novelDetailProvider(worksId)));
        }
        return const RequestLoading();
      }),
    ]);
  }

  Widget _buildSuccessContent(CommonNovel detail, NovelDetailWebView webViewData) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: NovelDetailPageLayout(
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
                    child: NovelDetailMenu(
                      detail: widget.args.detail ?? detail,
                    ),
                  );
                },
              )
            ],
          ),
          viewerContent: _buildContent(webViewData),
          collectButton: Container(),
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
                    AuthorCardWidget(user: detail.user, createDate: detail.createDate, tabController: _tabController),
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
              // sliver: SliverToBoxAdapter(child: CommentsPreviewContentWidget(worksId: worksId)),
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
                child: RelatedArtworksContentWidget(worksId: worksId),
              ),
            ),
          ]),
    );
  }

  Widget _buildContent(NovelDetailWebView webViewData) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SelectableText(webViewData.text),
    );
  }

  Widget _buildInformation(CommonNovel detail) {
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
