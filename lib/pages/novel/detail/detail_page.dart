import 'package:artvier/business_component/card/author_card.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/dialog_custom.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/layout/single_line_fitted_box.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/pages/novel/detail/logic.dart';
import 'package:artvier/pages/novel/detail/provider/novel_detail_provider.dart';
import 'package:artvier/pages/novel/detail/widgets/menu_bottom_sheet.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/routes.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class NovelDetailPage extends ConsumerStatefulWidget {
  final NovelDetailPageArguments args; // 数据集

  const NovelDetailPage(Object arguments, {super.key}) : args = arguments as NovelDetailPageArguments;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _NovelDetailState();
  }
}

class _NovelDetailState extends ConsumerState<NovelDetailPage> with TickerProviderStateMixin, NovelDetailPageLogic {
  @override
  get novelDetail => widget.args.detail;

  @override
  get worksId => widget.args.worksId;

  TextTheme get textTheme => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  @override
  void initState() {
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
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: AppBar(
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
      child: Stack(
        children: [
          CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: EnhanceNetworkImage(
                width: double.infinity,
                height: 180,
                image: ExtendedNetworkImageProvider(
                  HttpHostOverrides().pxImgUrl(novelDetail!.imageUrls.medium),
                  headers: const {"referer": CONSTANTS.referer},
                  cache: true,
                ),
              ),
            ),
            // 作品标题
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
                child: Text(detail.title, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ),
            ),
            // 概述信息
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // 作者卡片
                  AuthorCardWidget(user: detail.user, createDate: detail.createDate),
                  _buildInformation(detail),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: _buildContent(webViewData),
            ),
          ]),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
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
          ),
        ],
      ),
    );
  }

  Widget _buildContent(NovelDetailWebView webViewData) {
    final lines = webViewData.text.split('\n');
    List<InlineSpan> spanList = [];
    for (final line in lines) {
      // if (line.contains(RegExp(r'\[pixivimage:([0-9|\-])+\]'))) {
      //   spanList.add(const TextSpan(text: '(pixivimage)\n'));
      // } else {
      spanList.add(TextSpan(text: '$line\n'));
      // }
    }
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SelectableText.rich(TextSpan(children: spanList)),
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
          // 简介
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: HtmlWidget(
              detail.caption,
              onTapUrl: (url) => showOpenLinkDialog(context, url),
            ),
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
}
