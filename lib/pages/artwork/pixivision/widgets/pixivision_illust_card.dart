import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/pages/artwork/detail/arguments/illust_detail_page_args.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:artvier/routes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 用户详情页的用户面板组件
class PixivisionIllustCard extends BasePage {
  const PixivisionIllustCard({
    super.key,
    required this.illustId,
    required this.illustUrl,
    required this.illustTitle,
    required this.authorId,
    required this.authorName,
    required this.authorAvatarUrl,
    this.description,
  });

  final String illustId;

  final String illustUrl;

  final String illustTitle;

  final String authorId;

  final String authorName;

  final String authorAvatarUrl;

  final List<String>? description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
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
                          headers: HttpHostOverrides().pximgHeaders,
                          cache: true,
                        ),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(illustTitle),
                        Text("By $authorName", style: textTheme(context).bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(
                RouteNames.artworkDetail.name,
                arguments: IllustDetailPageArguments(illustId: illustId, title: illustTitle),
              ),
              child: EnhanceNetworkImage(
                image: ExtendedNetworkImageProvider(
                  HttpHostOverrides().pxImgUrl(illustUrl),
                  headers: HttpHostOverrides().pximgHeaders,
                  cache: true,
                ),
              ),
            ),
          ),
          if (description != null)
            for (final text in description!)
              if (text.trim() != '')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(text),
                )
        ],
      ),
    );
  }
}
