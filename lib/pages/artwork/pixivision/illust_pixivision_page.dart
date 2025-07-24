import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/page_layout/banner_appbar_page_layout.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/pages/artwork/pixivision/logic.dart';
import 'package:artvier/pages/artwork/pixivision/model/pixivision_body_illust_item.dart';
import 'package:artvier/pages/artwork/pixivision/model/pixivision_webview_page_arguments.dart';
import 'package:artvier/pages/artwork/pixivision/widgets/pixivision_illust_card.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart';

class IllustPixivisionPage extends BaseStatefulPage {
  final PixivisionWebViewPageArguments arguments;

  const IllustPixivisionPage(Object arg, {super.key}) : arguments = arg as PixivisionWebViewPageArguments;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __IllustPixivisionPageState();
}

class __IllustPixivisionPageState extends BasePageState<IllustPixivisionPage> with IllustPixivisionPageLogic {
  /// 主体内容的R角
  final double _radius = 12;

  @override
  void initState() {
    super.initState();
    language = widget.arguments.language;
    pixvisionId = widget.arguments.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BannerAppBarPageLayout(
        bannerHeight: 200,
        appBarStartBuilderOffset: 0,
        appBarEndBuilderOffset: 200,
        appBarBuilder: (double offset) => _buildAppBar(offset),
        bannerWidget: _bannerWidget(),
        body: ExtendedNestedScrollView(
          onlyOneScrollInBody: true,
          // pinnedHeaderSliverHeightBuilder: () {
          //   return MediaQuery.of(context).padding.top + kToolbarHeight - _radius;
          // },
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 200 - _radius),
                ),
              ),
            ];
          },
          body: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0)),
            ),
            child: Builder(builder: (context) {
              return ref
                  .watch(
                    illustPixivisionProvier(
                      PixivisionWebViewPageArguments(
                        language: language,
                        id: pixvisionId,
                        coverUrl: widget.arguments.coverUrl,
                        title: widget.arguments.title,
                      ),
                    ),
                  )
                  .when(
                    data: (data) => Builder(
                      builder: (context) {
                        var document = parse(data);
                        var items = document.querySelector("._feature-article-body")?.children ?? [];
                        List<Widget> widgets = [];
                        for (var item in items) {
                          if (item.className == "_feature-article-body__paragraph") {
                            widgets.add(Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: HtmlWidget(
                                item.text,
                              ),
                            ));
                          } else if (item.className == "_feature-article-body__pixiv_illust") {
                            var illust = PixivisionBodyIllustItem(
                              illustUrl: item.querySelector("div.aiwsp__main img")?.attributes["src"].toString() ?? "",
                              illustTitle: item.querySelector(".aiwsp__title a")?.text ?? "",
                              illustId: item
                                      .querySelector("div.aiwsp__main a")
                                      ?.attributes["href"]
                                      ?.split('?')
                                      .first
                                      .split('/')
                                      .last ??
                                  "",
                              authorName: item.querySelector(".aiwsp__user-name a")?.text.toString() ?? "",
                              authorId: item
                                      .querySelector(".aiwsp__info a")
                                      ?.attributes["href"]
                                      ?.split('?')
                                      .first
                                      .split('/')
                                      .last ??
                                  "",
                              authorAvatar:
                                  item.querySelector(".aiwsp__uesr-icon img")?.attributes["src"].toString() ?? "",
                              description: item
                                  .querySelectorAll("._article-illust-work>p:not(:empty)")
                                  .map((e) => e.text)
                                  .toList(),
                            );
                            widgets.add(PixivisionIllustCard(
                              illustId: illust.illustId,
                              illustUrl: illust.illustUrl,
                              illustTitle: illust.illustTitle,
                              authorId: illust.authorId,
                              authorName: illust.authorName,
                              authorAvatarUrl: illust.authorAvatar,
                              description: illust.description,
                            ));
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: CustomScrollView(
                            slivers: [
                              // Title
                              SliverPadding(
                                padding: const EdgeInsets.only(top: 16),
                                sliver: SliverToBoxAdapter(
                                  child: Text(
                                    widget.arguments.title,
                                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // Content
                              for (final widget in widgets) SliverToBoxAdapter(child: widget),
                              // SafeArea
                              const SliverToBoxAdapter(
                                child: SafeArea(top: false, left: false, right: false, bottom: true, child: SizedBox()),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    error: (obj, e) => RequestLoadingFailed(onRetry: () {}),
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
    return EnhanceNetworkImage(
      image: ExtendedNetworkImageProvider(
        HttpHostOverrides().pxImgUrl(widget.arguments.coverUrl),
        headers: HttpHostOverrides().pximgHeaders,
        cache: true,
      ),
      color: const Color(0x33000000),
      colorBlendMode: BlendMode.multiply,
    );
  }

  // AppBar
  Widget _buildAppBar(double offset) {
    double bgOpacity = 0;
    double titleOpacity = 0;
    if (offset >= 100 && offset <= 150) {
      bgOpacity = (offset - 100) / 50;
    } else if (offset > 150) {
      bgOpacity = 1;
    }
    titleOpacity = bgOpacity;
    double reverseOpacity = 1 - bgOpacity; // AppBar背景色透明度的反向透明度
    Color buttonBackground = const Color(0x55000000).withAlpha((85 * reverseOpacity).toInt()); // back和action按钮的背景色
    int c = Theme.of(context).brightness == Brightness.light ? (255 * reverseOpacity).toInt() : 240;
    Color buttonForeground = Color.fromARGB(255, c, c, c);
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: Theme.of(context).colorScheme.surface.withValues(alpha: bgOpacity),
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
      // actions: [
      //   // 菜单按钮
      //   BlurButton(
      //     onPressed: () {},
      //     borderRadius: BorderRadius.circular(20.0),
      //     margin: const EdgeInsets.symmetric(horizontal: 8.0),
      //     background: buttonBackground,
      //     child: Icon(Icons.more_horiz_rounded, color: buttonForeground),
      //   ),
      // ],
    );
  }
}
