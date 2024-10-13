import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/routes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 用户详情页的用户面板组件
class PixivisionIllustCard extends ConsumerWidget {
  const PixivisionIllustCard(
    this.illustId,
    this.illustUrl,
    this.illustTitle,
    this.authorId,
    this.authorName,
    this.authorAvatarUrl, {
    super.key,
  });

  final String illustId;

  final String illustUrl;

  final String illustTitle;

  final String authorId;

  final String authorName;

  final String authorAvatarUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                RouteNames.userDetail.name,
                arguments: PreloadUserLeastInfo(authorId, authorName, authorAvatarUrl),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ClipOval(
                      child: EnhanceNetworkImage(
                        image: ExtendedNetworkImageProvider(
                          HttpHostOverrides().pxImgUrl(authorAvatarUrl),
                          headers: const {"Referer": CONSTANTS.referer},
                          cache: true,
                        ),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(illustTitle),
                      Text(authorName),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                RouteNames.artworkDetail.name,
                arguments: IllustDetailPageArguments(illustId: illustId, title: illustTitle),
              ),
              child: EnhanceNetworkImage(
                image: ExtendedNetworkImageProvider(
                  HttpHostOverrides().pxImgUrl(illustUrl),
                  headers: const {"Referer": CONSTANTS.referer},
                  cache: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
