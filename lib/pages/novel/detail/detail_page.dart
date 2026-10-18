import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/layout/app_navigator.dart';
import 'package:artvier/business_component/card/author_card.dart';
import 'package:artvier/business_component/series/series_navigation.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/layout/single_line_fitted_box.dart';
import 'package:artvier/component/loading/muted_works.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/provider/muted_state_provider.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:artvier/model_response/user/common_user.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_element.dart';
import 'package:artvier/pages/novel/detail/logic.dart';
import 'package:artvier/pages/novel/detail/provider/novel_detail_provider.dart';
import 'package:artvier/pages/novel/detail/widgets/menu_bottom_sheet.dart';
import 'package:artvier/pages/novel/detail/widgets/novel_elements.dart';
import 'package:artvier/pages/novel/detail/widgets/novel_overlay_settings.dart';
import 'package:artvier/database/database.dart';
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

  const NovelDetailPage(Object arguments, {super.key})
      : args = arguments as NovelDetailPageArguments;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return NovelDetailState();
  }
}

class NovelDetailState extends BasePageState<NovelDetailPage>
    with
        WidgetsBindingObserver,
        SingleTickerProviderStateMixin,
        NovelDetailPageLogic,
        NovelDetailOverlaySettingsAnimation<NovelDetailPage> {
  get novelDetail => widget.args.detail;

  @override
  get novelId => widget.args.novelId;

  bool _hasMountedListener = false;
  bool _firstScrolled = false;

  /// 待恢复的本地阅读进度（书签跳转优先时不使用）
  NovelReadingProgressTableData? _pendingRestoreProgress;

  /// 阅读进度是否已从数据库加载完毕
  bool _progressLoadDone = false;

  /// 缓存阅读器样式，供 dispose 时保存进度（避免使用已失效的 ref）
  double _cachedTextSize = 12;
  String? _cachedFontFamily;
  Color? _cachedForeground;

  @override
  get scrollController => _scrollController;

  late final ScrollController _scrollController;

  /// 渲染元素块
  List<NovelElementModel> elements = [];

  /// 与 elements 对齐的段落区间 [start, end)；分页线为 null
  List<({int start, int end})?> paragraphRanges = [];

  /// 已解析过的正文，用于避免重复解析
  String? _parsedNovelText;

  /// 容器 Key
  final GlobalKey _bodyKey = GlobalKey();

  // 使用 key 来保持 CustomScrollView 的状态
  final viewerScrollKey = GlobalKey();

  /// 小说章节标题样式
  get novelChapterTitleStyle =>
      textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    initOverlaySettingsState();
    WidgetsBinding.instance.addObserver(this);
    // 显式指定 toPage（如从书签进入）时不覆盖；否则恢复本地阅读进度
    if (widget.args.toPage == null) {
      _loadReadingProgress();
    } else {
      _progressLoadDone = true;
    }
  }

  Future<void> _loadReadingProgress() async {
    final progress = await appDatabase.getNovelReadingProgress(novelId);
    if (!mounted) return;
    setState(() {
      _pendingRestoreProgress = progress;
      _progressLoadDone = true;
    });
  }

  @override
  void dispose() {
    readingProgressSaveTimer?.cancel();
    if (_hasMountedListener) {
      _scrollController.removeListener(_onScroll);
    }
    _persistReadingProgress();
    _hasMountedListener = false;
    elements.clear();
    paragraphRanges.clear();
    _parsedNovelText = null;
    WidgetsBinding.instance.removeObserver(this);
    overlayAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _persistReadingProgress();
    }
  }

  ({double textSize, String? fontFamily, Color? foreground})
      _viewerTextStyle() {
    final settings = ref.read(novelViewerSettings);
    final viewerThemes = CONSTANTS.viewerThemes(context);
    final themeName = settings.themeName ?? 'default';
    final theme = viewerThemes[themeName];
    final isCustomTheme = themeName == 'custom' && settings.customTheme != null;
    final foreground = isCustomTheme
        ? Color(settings.customTheme!.foreground)
        : theme?.theme != null
            ? Color(theme!.theme!.foreground)
            : null;
    _cachedTextSize = settings.textSize;
    _cachedFontFamily = settings.fontFamily;
    _cachedForeground = foreground;
    return (
      textSize: settings.textSize,
      fontFamily: settings.fontFamily,
      foreground: foreground
    );
  }

  void _persistReadingProgress() {
    if (!mounted || !_hasMountedListener) return;
    // dispose 阶段不能使用 ref，只用缓存样式
    saveReadingProgress(
      context,
      elements,
      paragraphRanges,
      _bodyKey,
      textSize: _cachedTextSize,
      fontFamily: _cachedFontFamily,
      foreground: _cachedForeground,
    );
  }

  void _onScroll() {
    if (!mounted) return;
    overlayShow = false;
    animateOverlay();
    scheduleSaveReadingProgress(
      context,
      elements,
      paragraphRanges,
      _bodyKey,
      textSize: _cachedTextSize,
      fontFamily: _cachedFontFamily,
      foreground: _cachedForeground,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasMountedListener) {
      _scrollController = PrimaryScrollController.of(context);
      _scrollController.addListener(_onScroll);
      _hasMountedListener = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mutedState = ref.watch(globalMutedStateProvider);
    if (widget.args.detail != null &&
        mutedState.containsNovel(widget.args.detail!)) {
      return Scaffold(body: _buildMutedContent());
    }
    final result = Scaffold(
      body: Container(
        key: _bodyKey,
        child: ref.watch(novelWebViewDetailProvider(novelId)).when(
            data: (data) => mutedState.containsNovelWebView(data)
                ? _buildMutedContent()
                : _buildSuccessContent(data),
            error: (obj, error) => _buildBeforeSuccessContent(true),
            loading: () => _buildBeforeSuccessContent(false)),
      ),
    );

    if (elements.isNotEmpty && !_firstScrolled && _progressLoadDone) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (widget.args.toPage != null && widget.args.toPage! > -1) {
          scrollToPage(context, elements, _bodyKey, false, widget.args.toPage!);
        } else if (_pendingRestoreProgress != null &&
            (_pendingRestoreProgress!.paragraphIndex >= 0 ||
                _pendingRestoreProgress!.page > 1)) {
          final style = _viewerTextStyle();
          restoreReadingProgress(
            context,
            elements,
            paragraphRanges,
            _bodyKey,
            _pendingRestoreProgress!,
            textSize: style.textSize,
            fontFamily: style.fontFamily,
            foreground: style.foreground,
          );
        }
        _firstScrolled = true;
      });
    }
    return result;
  }

  /// 显示作品被屏蔽
  Widget _buildMutedContent() {
    return Stack(children: [
      AppBar(
        // backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: const AppbarLeadingButtton(enableBackground: true),
        title: SingleLineFittedBox(
            child: Text(widget.args.title ?? widget.args.novelId)),
      ),
      MutedWorks(),
    ]);
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
          title: SingleLineFittedBox(
              child: Text(widget.args.title ?? widget.args.novelId)),
        ),
      ),
      Builder(builder: (context) {
        if (isFailed) {
          return RequestLoadingFailed(
              onRetry: () => ref.refresh(novelWebViewDetailProvider(novelId)));
        }
        return const RequestLoading();
      }),
    ]);
  }

  /// 收藏按钮
  Widget _collectButton() {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onLongPress: (() => handleLongTapCollect(ref)),
      child: GestureDetector(
        onTap: () => handleTapCollect(ref),
        child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              gradient: LinearGradient(colors: [
                colorScheme.surface,
                colorScheme.surface,
                colorScheme.surface,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
            child: Consumer(builder: ((context, ref, child) {
              CollectState status = ref.watch(novelDetailCollectStateProvider);
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
                case CollectState.loading:
                  return Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey.withAlpha(100),
                    size: 28,
                  );
              }
            }))),
      ),
    );
  }

  Widget _buildSuccessContent(NovelDetailWebView webViewData) {
    final viewerThemes = CONSTANTS.viewerThemes(context);
    // 页面主题色
    final settings = ref.watch(novelViewerSettings);
    final themeName = settings.themeName ?? 'default';
    final theme = viewerThemes[themeName];
    final isCustomTheme = themeName == 'custom' && settings.customTheme != null;
    final background = isCustomTheme
        ? Color(settings.customTheme!.background)
        : theme?.theme != null
            ? Color(theme!.theme!.background)
            : null;
    final foreground = isCustomTheme
        ? Color(settings.customTheme!.foreground)
        : theme?.theme != null
            ? Color(theme!.theme!.foreground)
            : null;
    _cachedTextSize = settings.textSize;
    _cachedFontFamily = settings.fontFamily;
    _cachedForeground = foreground;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Container(
        color: background,
        child: Stack(
          children: [
            CustomScrollView(
              key: viewerScrollKey,
              slivers: [
                // 小说信息
                SliverToBoxAdapter(
                  child: Container(
                    color: colorScheme.surface,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            EnhanceNetworkImage(
                              width: double.infinity,
                              height: 180,
                              image: ExtendedNetworkImageProvider(
                                HttpHostOverrides()
                                    .pxImgUrl(webViewData.novel.coverUrl),
                                headers: HttpHostOverrides()
                                    .imageHeaders(webViewData.novel.coverUrl),
                                cache: true,
                              ),
                            ),
                          ],
                        ),
                        // 作品标题
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 16.0, bottom: 4.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text.rich(
                                  TextSpan(children: [
                                    if (webViewData.novel.tags.contains("R-18"))
                                      TextSpan(
                                        text: "R18  ",
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: const Color(0xFFFF3855),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    if (webViewData.novel.seriesId != null &&
                                        webViewData.novel.seriesId != "")
                                      TextSpan(
                                        text: "${l10n.series}  ",
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: const Color(0xfffeaf0f),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    TextSpan(text: webViewData.novel.title),
                                  ]),
                                  style: textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: _collectButton(),
                              ),
                            ],
                          ),
                        ),
                        // 概述信息
                        AuthorCardWidget(
                            user: CommonUser(
                              id: webViewData.authorDetails.userId,
                              name: webViewData.authorDetails.userName,
                              profileImageUrls: Profile_image_urls(
                                  medium:
                                      webViewData.authorDetails.profileImg.url),
                              isFollowed: webViewData.authorDetails.isFollowed,
                            ),
                            createDate: webViewData.novel.cdate),
                        _buildInformation(webViewData),
                        // 系列
                        if (webViewData.novel.seriesId != null &&
                            webViewData.novel.seriesId != "")
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child:
                                NovelSeriesNavigation(novel: webViewData.novel),
                          ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Divider(
                              color: colorScheme.outline.withAlpha(100)),
                        ),
                      ],
                    ),
                  ),
                ),

                ..._buildContent(webViewData, background, foreground),
              ],
            ),
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
                    icon: const Icon(Icons.more_horiz_rounded,
                        color: Colors.white),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    onPressed: () {
                      BottomSheets.showCustomBottomSheet<bool>(
                        context: context,
                        exitOnClickModal: true,
                        enableDrag: false,
                        child: NovelDetailMenu(
                          novelId: webViewData.novel.id,
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
              bottom: 0,
              child: SlideTransition(
                position: overlayOffsetAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: NovelDetailOverlaySettings(
                    novelId: novelId,
                    webViewData: webViewData,
                    catalogCallback: (index, name) {
                      scrollToChapter(
                          context, elements, _bodyKey, false, index);
                      Navigator.maybeOf(context)?.pop();
                    },
                    markerCallback: (callback) => handleMarkerClick(
                        context, elements, _bodyKey, callback),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 解析小说正文为渲染元素（正文变化时才重新解析，保持 GlobalKey 稳定）
  void _ensureElementsParsed(NovelDetailWebView webViewData) {
    if (_parsedNovelText == webViewData.novel.text && elements.isNotEmpty) {
      return;
    }
    elements.clear();
    paragraphRanges.clear();
    _parsedNovelText = webViewData.novel.text;
    final lines = webViewData.novel.text.split('\n');
    var nextParagraph = 0;

    for (final line in lines) {
      // 新页
      if (line.startsWith('[newpage]')) {
        elements.add(NovelElementModel(
            type: NovelElementType.pageDivider,
            key: GlobalKey(),
            element: const NovelPageDivider()));
        paragraphRanges.add(null);
        continue;
      }
      // 断章，章节标题
      final chapterMatch = RegExp(r'\[chapter:([^\n\]]+)\]').firstMatch(line);
      if (line.startsWith('[chapter') && (chapterMatch?.groupCount ?? 0) > 0) {
        final text = chapterMatch?.group(1);
        if (text != null) {
          final textSpan =
              TextSpan(text: '$text\n', style: novelChapterTitleStyle);
          elements.add(NovelElementModel(
            type: NovelElementType.chapterTitle,
            key: GlobalKey(),
            element: [textSpan],
          ));
          paragraphRanges.add((start: nextParagraph, end: nextParagraph + 1));
          nextParagraph++;
        }
        continue;
      }
      // 其他内容：合并连续文本块渲染，但按行累计段落序号
      final textSpan = TextSpan(text: '$line\n');
      if (elements.isNotEmpty && elements.last.type == NovelElementType.text) {
        (elements.last.element as NovelTextElement).add(textSpan);
        final last = paragraphRanges.last!;
        paragraphRanges[paragraphRanges.length - 1] =
            (start: last.start, end: last.end + 1);
      } else {
        elements.add(NovelElementModel(
            type: NovelElementType.text,
            key: GlobalKey(),
            element: [textSpan]));
        paragraphRanges.add((start: nextParagraph, end: nextParagraph + 1));
      }
      nextParagraph++;
    }
  }

  /// 小说内容
  List<Widget> _buildContent(
      NovelDetailWebView webViewData, Color? background, Color? foreground) {
    final settings = ref.watch(novelViewerSettings);
    _ensureElementsParsed(webViewData);

    // TextPainter textPainter = TextPainter(text: TextSpan(children: spanList), textDirection: TextDirection.ltr);
    // textPainter.layout();
    // final caretOffset = textPainter.getOffsetForCaret(
    //   TextPosition(offset: 106),
    //   Rect.zero,
    // );
    // print(caretOffset);

    final List<Widget> results = [];
    for (int i = 0; i < elements.length; i++) {
      final element = elements[i];
      switch (element.type) {
        case NovelElementType.chapterTitle:
          results.add(SliverPadding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 4, left: 20, right: 20),
            sliver: SliverToBoxAdapter(
              child: NovelText(
                key: element.key,
                textSpanList: element.element,
                textSize: settings.textSize,
                fontFamily: settings.fontFamily,
                foreground: foreground,
                onTap: () {
                  overlayShow = !overlayShow;
                  animateOverlay();
                },
              ),
            ),
          ));
          break;
        case NovelElementType.text:
          results.add(SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: NovelText(
                key: element.key,
                textSpanList: element.element,
                textSize: settings.textSize,
                fontFamily: settings.fontFamily,
                foreground: foreground,
                onTap: () {
                  overlayShow = !overlayShow;
                  animateOverlay();
                },
              ),
            ),
          ));
          break;

        case NovelElementType.pageDivider:
          results.add(SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver:
                SliverToBoxAdapter(child: NovelPageDivider(key: element.key)),
          ));
          break;

        /// TODO: 小说插图
        case NovelElementType.illust:
          break;
      }
    }
    return results;
  }

  Widget _buildInformation(NovelDetailWebView webViewData) {
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
                      child: Text("id: ${webViewData.novel.id}",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey))),
                  // 收藏数
                  Expanded(
                    flex: 1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.favorite,
                              size: 18, color: Colors.grey),
                          Text(" ${webViewData.novel.rating.bookmark}",
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey)),
                        ]),
                  ),
                  // 浏览数
                  Expanded(
                    flex: 1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.remove_red_eye,
                              size: 18, color: Colors.grey),
                          Text(" ${webViewData.novel.rating.view}",
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey)),
                        ]),
                  ),
                ],
              )),
          // 简介
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: HtmlWidget(
              webViewData.novel.caption,
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
                for (var element in webViewData.novel.tags)
                  _tagItemWidget(element, null)
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
            AppNavigator.pushNamed(context, RouteNames.searchResult.name, arguments: text);
          },
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "#$text ",
              style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        // 标签的翻译文字
        if (translateText != null)
          Text("$translateText  ", style: textTheme.bodySmall),
      ],
    );
  }
}
