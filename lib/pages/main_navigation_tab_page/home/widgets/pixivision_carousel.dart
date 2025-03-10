import 'package:artvier/component/carousel/blur_carousel.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/model_response/illusts/pixivision/spotlight_articles.dart';
import 'package:artvier/pages/artwork/pixivision/model/pixivision_webview_page_arguments.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/routes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Pixivsion 轮播图
class PixivsionCarousel extends ConsumerWidget {
  final List<SpotlightArticle> articleList;

  const PixivsionCarousel({
    super.key,
    required this.articleList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var list = articleList;
    return BlurCarousel(
      itemCount: list.length,
      loop: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(
              top: (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.paddingOf(context).top),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                clipBehavior: Clip.antiAlias,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashFactory: InkSparkle.splashFactory,
                    onTap: () {
                      Navigator.of(ref.context).pushNamed(
                        RouteNames.artworkPixivition.name,
                        arguments: PixivisionWebViewPageArguments(
                            language: "zh",
                            id: list[index].id,
                            title: list[index].title,
                            coverUrl: list[index].thumbnail),
                      );
                    },
                    child: Column(
                      children: [
                        EnhanceNetworkImage(
                          height: 100,
                          width: double.infinity,
                          image: ExtendedNetworkImageProvider(
                            HttpHostOverrides().pxImgUrl(list[index].thumbnail),
                            headers: HttpHostOverrides().pximgHeaders,
                          ),
                          fit: BoxFit.cover,
                          loadingWidget: (context, url, progress) =>
                              Container(color: const Color.fromARGB(30, 112, 112, 112)),
                          fadeInCurve: Curves.decelerate,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.brightness == Brightness.light
                                ? const Color.fromARGB(50, 0, 0, 0)
                                : const Color.fromARGB(100, 0, 0, 0),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            list[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      backgroundBuilder: (int index) {
        return Stack(
          children: [
            EnhanceNetworkImage(
              image: ExtendedNetworkImageProvider(
                HttpHostOverrides().pxImgUrl(list[index].thumbnail),
                headers: HttpHostOverrides().pximgHeaders,
              ),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned.fill(
              child: Container(color: const Color.fromARGB(40, 0, 0, 0)),
            )
          ],
        );
      },
    );
  }
}
