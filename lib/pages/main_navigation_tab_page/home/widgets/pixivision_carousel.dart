import 'package:artvier/component/carousel/blur_carousel.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/provider/home_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Pixivsion 轮播图
class PixivsionCarousel extends ConsumerWidget {
  const PixivsionCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pixivisions = ref.watch(homePixivisionProvider);
    var list = pixivisions;
    return BlurCarousel(
      itemCount: list.length,
      loop: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(
              top: (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) + MediaQuery.paddingOf(context).top),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                EnhanceNetworkImage(
                  height: 100,
                  width: double.infinity,
                  image: ExtendedNetworkImageProvider(
                    list[index].thumbnail,
                    headers: const {"Referer": CONSTANTS.referer},
                  ),
                  fit: BoxFit.cover,
                  loadingWidget: (context, url, progress) => Container(color: const Color.fromARGB(30, 112, 112, 112)),
                  fadeInCurve: Curves.decelerate,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.brightness == Brightness.light
                        ? const Color.fromARGB(50, 0, 0, 0)
                        : const Color.fromARGB(100, 0, 0, 0),
                    borderRadius:
                        const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
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
        );
      },
      backgroundBuilder: (int index) {
        return Stack(
          children: [
            EnhanceNetworkImage(
              image: ExtendedNetworkImageProvider(
                list[index].thumbnail,
                headers: const {"Referer": CONSTANTS.referer},
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
