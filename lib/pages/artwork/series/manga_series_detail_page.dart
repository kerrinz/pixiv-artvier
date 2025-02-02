import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/manga_listview/manga_gridview.dart';
import 'package:artvier/business_component/page_layout/banner_appbar_page_layout.dart';
import 'package:artvier/component/badge.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/config/http_base_options.dart';
import 'package:artvier/pages/artwork/series/model/arguments.dart';
import 'package:artvier/pages/artwork/series/provider.dart';
import 'package:artvier/pages/artwork/series/widget/author_card.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MangaSeriesDetailPage extends BaseStatefulPage {
  final MangaSeriesDetailPagePageArguments arguments;

  const MangaSeriesDetailPage(Object arg, {super.key}) : arguments = arg as MangaSeriesDetailPagePageArguments;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __MangaSeriesDetailPageState();
}

class __MangaSeriesDetailPageState extends BasePageState<MangaSeriesDetailPage> {
  static const double _bannerHeight = 200;

  double get _endAppBarBackgroundOffset => _bannerHeight - kToolbarHeight - MediaQuery.of(context).padding.top;

  double get _startAppBarBackgroundOffset => _endAppBarBackgroundOffset - _deltaAppBarBackgroundOffset;

  static const double _deltaAppBarBackgroundOffset = 30;

  // double get _endAppBarTitleOffset => _endAppBarBackgroundOffset;

  double get _startAppBarTitleOffset => _startAppBarBackgroundOffset;

  static const double _deltaAppBarTitleOffset = 30;

  /// 主体内容的R角
  final double _radius = 12;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BannerAppBarPageLayout(
        bannerHeight: _bannerHeight,
        appBarStartBuilderOffset: _startAppBarBackgroundOffset,
        appBarEndBuilderOffset: _endAppBarBackgroundOffset,
        appBarBuilder: (double offset) => _buildAppBar(offset),
        bannerWidget: _bannerWidget(),
        body: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          pinnedHeaderSliverHeightBuilder: () {
            return MediaQuery.of(context).padding.top + kToolbarHeight - _radius;
          },
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: _bannerHeight - _radius),
                ),
              ),
            ];
          },
          body: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0)),
            ),
            child: Consumer(builder: (context, ref, child) {
              return ref.watch(mangaSeriesDetailProvider(widget.arguments.id.toString())).when(
                    data: (data) => CustomScrollView(
                      slivers: [
                        // 系列信息
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.illustSeriesDetail.title,
                                  style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: MyBadge(
                                    color: const Color(0xfffeaf0f),
                                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Text(i10n.series,
                                        style: textTheme.labelSmall?.copyWith(color: Colors.white, height: 1)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(data.illustSeriesDetail.caption,
                                      style: textTheme.bodySmall?.copyWith(height: 1.4)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // 作者信息
                        SliverPadding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 12),
                          sliver: SliverToBoxAdapter(
                            child: MangaSeriesAuthorCardWidget(
                              user: data.illustSeriesDetail.user,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          sliver: SliverToBoxAdapter(
                            child: Text(i10n.seriesTotals(data.illustSeriesDetail.seriesWorkCount)),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(top: 0),
                          sliver: SliverMangaGridView(
                            artworkList: data.illusts,
                            onLazyload: () async =>
                                ref.read(mangaSeriesDetailProvider(widget.arguments.id.toString()).notifier).next(),
                          ),
                        ),
                      ],
                    ),
                    error: (obj, e) => RequestLoadingFailed(
                      onRetry: () =>
                          ref.read(mangaSeriesDetailProvider(widget.arguments.id.toString()).notifier).reload(),
                    ),
                    loading: () => const RequestLoading(),
                  );
            }),
          ),
        ),
      ),
    );
  }

  // Banner
  Widget _bannerWidget() {
    return Stack(
      children: [
        EnhanceNetworkImage(
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          image: ExtendedNetworkImageProvider(
            HttpHostOverrides().pxImgUrl(widget.arguments.url),
            headers: HttpBaseOptions.pximgHeaders,
            cache: true,
          ),
        ),
        const Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(color: Colors.black12))),
      ],
    );
  }

  // AppBar
  Widget _buildAppBar(double offset) {
    double bgOpacity;
    double titleOpacity;
    // 首次加载时offset是0
    if (offset == 0) {
      bgOpacity = 0;
    } else if (offset <= _endAppBarBackgroundOffset) {
      bgOpacity = (offset - _startAppBarBackgroundOffset) / _deltaAppBarBackgroundOffset;
    } else {
      bgOpacity = 1;
    }
    if (offset >= _startAppBarTitleOffset) {
      titleOpacity = (offset - _startAppBarTitleOffset) / _deltaAppBarTitleOffset;
      if (titleOpacity > 1) titleOpacity = 1;
    } else {
      titleOpacity = 0;
    }
    double reverseOpacity = 1 - bgOpacity; // AppBar背景色透明度的反向透明度
    Color buttonBackground = const Color(0x55000000).withAlpha((85 * reverseOpacity).toInt()); // back和action按钮的背景色
    int c = Theme.of(context).brightness == Brightness.light ? (255 * reverseOpacity).toInt() : 240;
    Color buttonForeground = Color.fromARGB(255, c, c, c);
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(bgOpacity),
      leading: BlurButton(
        onPressed: () {
          Navigator.of(context).pop(-1);
        },
        borderRadius: const BorderRadius.all(Radius.circular(18.0)),
        padding: const EdgeInsets.all(6.0),
        background: buttonBackground,
        child: Icon(Icons.arrow_back_ios_rounded, size: 20, color: buttonForeground),
      ),
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      title: Opacity(
        opacity: titleOpacity,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            widget.arguments.title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
