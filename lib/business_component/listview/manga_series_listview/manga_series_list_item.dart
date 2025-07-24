import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/manga/manga_series_list.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/routes.dart';
import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/image/enhance_network_image.dart';

class ManagaSeriesListItem extends ConsumerStatefulWidget {
  const ManagaSeriesListItem({
    super.key,
    required this.mangaSeries,
    this.onTap,
  });

  final MangaSeries mangaSeries;

  /// 点击卡片的事件
  final VoidCallback? onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManagaSeriesListItemState();
}

class _ManagaSeriesListItemState extends ConsumerState<ManagaSeriesListItem> {
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  TextTheme get textTheme => Theme.of(context).textTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ManagaSeriesListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  LocalizationIntl get l10n => LocalizationIntl.of(context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: EnhanceNetworkImage(
                image: ExtendedNetworkImageProvider(
                  HttpHostOverrides().pxImgUrl(widget.mangaSeries.url),
                  headers: HttpHostOverrides().pximgHeaders,
                  cache: true,
                ),
                fit: BoxFit.cover,
                width: 82,
                height: 110,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 110,
              width: double.infinity,
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.mangaSeries.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(widget.mangaSeries.user.name, style: textTheme.bodySmall?.copyWith(height: 2)),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(l10n.seriesUpdateTo(widget.mangaSeries.publishedContentCount),
                            style: textTheme.bodySmall
                                ?.copyWith(color: textTheme.bodySmall?.color?.withValues(alpha: 0.5), height: 1.5)),
                        Text(
                          formatDate(
                            widget.mangaSeries.lastPublishedContentDatetime.toLocal(),
                            [yyyy, '-', mm, '-', dd, ' '],
                          ),
                          style: textTheme.bodyMedium?.copyWith(color: textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
                        ),
                      ]),
                ],
              ),
            ),
          ),
          // 最新话
          CupertinoButton(
            padding: EdgeInsets.zero,
            color: Colors.transparent,
            onPressed: () => Navigator.of(ref.context).pushNamed(
              RouteNames.artworkDetail.name,
              arguments: IllustDetailPageArguments(
                  illustId: widget.mangaSeries.latestContentId.toString(), title: widget.mangaSeries.title),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.primary.withValues(alpha: 0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                // color: colorScheme.primary.withValues(alpha: 0.1),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2.0),
                    child: Icon(
                      Icons.bookmark_outline_rounded,
                      color: colorScheme.primary,
                      size: 16,
                      fill: 1,
                    ),
                  ),
                  Text(
                    l10n.seriesLatestChapter,
                    style: textTheme.labelMedium
                        ?.copyWith(color: colorScheme.primary, height: 1, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 格式化总收藏量
  String formatTotalCollected(int number) {
    if (number > 1000000) {
      return "${(number / 1000000).floor()}M";
    }
    if (number > 1000) {
      return "${(number / 1000).floor()}K";
    } else {
      return number.toString();
    }
  }
}
