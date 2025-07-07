import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/card/author_card.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/dialog_custom.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/layout/single_line_fitted_box.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/pages/novel/detail/logic.dart';
import 'package:artvier/pages/novel/detail/provider/novel_detail_provider.dart';
import 'package:artvier/pages/novel/detail/widgets/menu_bottom_sheet.dart';
import 'package:artvier/pages/novel/detail/widgets/novel_overlay_settings.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _NovelDetailState extends BasePageState<NovelDetailPage>
    with SingleTickerProviderStateMixin, NovelDetailPageLogic, NovelDetailOverlaySettingsAnimation<NovelDetailPage> {
  @override
  get novelDetail => widget.args.detail;

  @override
  get worksId => widget.args.worksId;

  bool _hasMountedListener = false;
  bool _firstScrolled = false;

  late final ScrollController _scrollController;

  /// 章节 Keys
  final List<GlobalKey> _chaptersKey = [];

  /// 容器 Key
  final GlobalKey _bodyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initOverlaySettingsState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasMountedListener) {
      _scrollController = PrimaryScrollController.of(context);
      _hasMountedListener = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = Scaffold(
      body: Container(
        key: _bodyKey, // 关键：标记页面内容区域
        child: ref.watch(novelDetailProvider(worksId)).when(
              data: (detailResponse) {
                return ref.watch(novelDetailWebViewProvider(worksId)).when(
                    data: (data) => _buildSuccessContent(detailResponse!.novel, data!),
                    error: (obj, error) => _buildBeforeSuccessContent(true),
                    loading: () => _buildBeforeSuccessContent(false));
              },
              error: (obj, error) => _buildBeforeSuccessContent(true),
              loading: () => _buildBeforeSuccessContent(false),
            ),
      ),
    );

    if (!_firstScrolled && widget.args.toPage != null && widget.args.toPage! > -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.args.toPage! < _chaptersKey.length) {
          scrollToChapter(true, widget.args.toPage!);
          _firstScrolled = true;
        }
      });
    }
    return result;
  }

  Widget _buildBeforeSuccessContent(bool isFailed) {
    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: AppBar(
          // backgroundColor: Colors.transparent,
          leading: const AppbarLeadingButtton(),
          shadowColor: Colors.transparent,
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
                  HttpHostOverrides().pxImgUrl(detail.imageUrls.medium),
                  headers: HttpHostOverrides().pximgHeaders,
                  cache: true,
                ),
              ),
            ),
            // 作品标题
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                child: Text.rich(
                  TextSpan(children: [
                    if (detail.xRestrict == 1)
                      TextSpan(
                        text: "R18  ",
                        style: textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFFFF3855),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    TextSpan(text: detail.title),
                  ]),
                  style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
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
            ..._buildContent(webViewData),
          ]),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
              leading: const AppbarLeadingButtton(
                color: Colors.white,
                enableBackground: true,
              ),
              actions: [
                AppbarBlurIconButton(
                  icon: const Icon(Icons.more_horiz_rounded, color: Colors.white),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  onPressed: () {
                    BottomSheets.showCustomBottomSheet<bool>(
                      context: context,
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
          // 设置栏
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: SlideTransition(
              position: overlayOffsetAnimation,
              child: NovelDetailOverlaySettings(
                novel: detail,
                webViewData: webViewData,
                catalogCallback: (index, name) {
                  scrollToChapter(false, index + 1);
                  Navigator.maybeOf(context)?.pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 滚动到第几章节，0是首页前的内容，1是首页
  scrollToChapter(bool animate, int chapterIndex) {
    RenderBox targetBox = _chaptersKey[chapterIndex].currentContext!.findRenderObject() as RenderBox;
    RenderBox bodyBox = _bodyKey.currentContext!.findRenderObject() as RenderBox;

    Offset targetPosition = targetBox.localToGlobal(Offset.zero);
    Offset bodyPosition = bodyBox.localToGlobal(Offset.zero);

    double relative = (targetPosition - bodyPosition).dy +
        _scrollController.offset -
        kToolbarHeight -
        MediaQuery.paddingOf(context).top;
    animate
        ? _scrollController.animateTo(
            relative,
            duration: Durations.extralong1,
            curve: Curves.fastEaseInToSlowEaseOut,
          )
        : _scrollController.jumpTo(relative);
  }

  /// 小说内容
  List<Widget> _buildContent(NovelDetailWebView webViewData) {
    final settings = ref.watch(novelViewerSettings);
    final lines = webViewData.text.split('\n');
    List<InlineSpan> spanList = [];
    // 拆分章节
    List<List<InlineSpan>> chapters = [];
    chapters.add([]);
    _chaptersKey.add(GlobalKey());

    for (final line in lines) {
      // 首页
      if (line.startsWith('[newpage]')) {
        chapters.add([]);
        _chaptersKey.add(GlobalKey());
        const textSpan = TextSpan(text: '——————');
        chapters.last.add(textSpan);
        spanList.add(textSpan);
        continue;
      }
      // 断章
      final chapterMatch = RegExp(r'\[chapter:([^\n\]]+)\]').firstMatch(line);
      if (line.startsWith('[chapter') && (chapterMatch?.groupCount ?? 0) > 0) {
        final text = chapterMatch?.group(1);
        if (text != null) {
          chapters.add([]);
          _chaptersKey.add(GlobalKey());
          final textSpan =
              TextSpan(text: '$text\n', style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold));
          chapters.last.add(textSpan);
          spanList.add(textSpan);
        }
        continue;
      }
      // 其他内容
      final textSpan = TextSpan(text: '$line\n');
      chapters.last.add(textSpan);
      spanList.add(textSpan);
    }

    // TextPainter textPainter = TextPainter(text: TextSpan(children: spanList), textDirection: TextDirection.ltr);
    // textPainter.layout();
    // final caretOffset = textPainter.getOffsetForCaret(
    //   TextPosition(offset: 106),
    //   Rect.zero,
    // );
    // print(caretOffset);

    return [
      for (int i = 0; i < chapters.length; i++)
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverToBoxAdapter(
            child: SelectableText.rich(
              TextSpan(children: chapters[i]),
              key: _chaptersKey[i],
              style: textTheme.bodyLarge?.copyWith(fontSize: settings.textSize),
              onTap: () {
                overlayShow = !overlayShow;
                animateOverlay();
              },
            ),
          ),
        )
    ];
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
