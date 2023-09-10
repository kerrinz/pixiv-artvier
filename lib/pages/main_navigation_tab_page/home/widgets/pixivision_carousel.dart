import 'package:artvier/component/carousel/blur_carousel.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/provider/home_pixivision_provider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PixivsionCarousel extends ConsumerWidget {
  const PixivsionCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var pixivisions = ref.watch(homePixivisionProvider);
    var list = pixivisions.asData?.value ?? [];
    return BlurCarousel(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
            clipBehavior: Clip.antiAlias,
            child: EnhanceNetworkImage(
              image: ExtendedNetworkImageProvider(
                list[index].thumbnail,
                headers: const {"Referer": CONSTANTS.referer},
              ),
              loadingWidget: (context, url, progress) => Container(color: const Color.fromARGB(30, 112, 112, 112)),
              fadeInCurve: Curves.decelerate,
            ),
          ),
        );
      },
      backgroundBuilder: (int index) {
        return EnhanceNetworkImage(
          image: ExtendedNetworkImageProvider(
            list[index].thumbnail,
            headers: const {"Referer": CONSTANTS.referer},
          ),
          // fit: BoxFit.cover,
        );
      },
    );
  }
}
