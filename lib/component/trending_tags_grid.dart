import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/model_response/illusts/illust_trending_tags.dart';
import 'package:artvier/routes.dart';

class TrendingTagsGrid extends StatelessWidget {
  final List<TrendTags> tags;

  const TrendingTagsGrid({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: tags.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) => _buildItem(context, index),
    );
  }

  Widget _buildItem(BuildContext context, index) {
    if (tags.isEmpty) {
      return const Text("暂无");
    }
    var item = tags[index];
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: EnhanceNetworkImage(
            image: ExtendedNetworkImageProvider(
              HttpHostOverrides().pxImgUrl(item.illust.imageUrls.squareMedium),
              headers: HttpHostOverrides().pximgHeaders,
              cache: true,
            ),
            fit: BoxFit.cover,
          ),
        ),
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black12,
                  Colors.black45,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 8,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  "#${item.tag}",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                if (item.translatedName != null && item.translatedName != "")
                  Text(
                    item.translatedName!,
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  )
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.black26,
              splashFactory: NoSplash.splashFactory,
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.searchResult.name, arguments: item.tag);
              },
              onLongPress: () => Navigator.of(context).pushNamed(
                RouteNames.artworkDetail.name,
                arguments: IllustDetailPageArguments(
                  illustId: item.illust.id.toString(),
                  title: item.illust.title,
                  detail: item.illust,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SliverTrendingTagsGrid extends TrendingTagsGrid {
  const SliverTrendingTagsGrid({super.key, required super.tags});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: _buildItem,
      itemCount: tags.length,
    );
  }
}
