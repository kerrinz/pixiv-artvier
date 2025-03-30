import 'package:artvier/base/base_page.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:artvier/pages/artwork/detail/provider/illust_comment_provider.dart';
import 'package:artvier/routes.dart';

/// 评论预览区域，仅含小部分评论
class CommentsPreviewContentWidget extends BasePage {
  const CommentsPreviewContentWidget({super.key, required this.artworkId});

  final String artworkId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 评论列表区域
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          // padding: const EdgeInsets.only(top: 8, bottom: 0),
          // decoration: BoxDecoration(
          //   color: colorScheme.primary.withAlpha(16),
          //   borderRadius: const BorderRadius.all(Radius.circular(16)),
          // ),
          child: Consumer(builder: ((context, ref, child) {
            var provider = ref.watch(commentsPreviewProvider(artworkId));
            return provider.when(
              data: ((data) {
                int len = data.length < 3 ? data.length : 3;
                List<Widget> widgets = [];
                for (int i = 0; i < len; i++) {
                  widgets.add(_CommentItem(comment: data[i]));
                }
                return Column(
                  children: [
                    ...widgets,
                  ],
                );
              }),
              error: ((error, stackTrace) => SizedBox(
                    height: 200,
                    child: RequestLoadingFailed(onRetry: () async => ref.refresh(commentsPreviewProvider(artworkId))),
                  )),
              loading: (() => const SizedBox(height: 200, child: RequestLoading())),
            );
          })),
        ),
        // 查看更多的按钮区域
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          padding: const EdgeInsets.only(top: 12, bottom: 8),
          child: CupertinoButton(
            minSize: null,
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: colorScheme.primary.withAlpha(32),
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            child: Text(l10n(context).viewMore, style: textTheme.labelLarge?.copyWith(color: colorScheme.primary)),
            onPressed: () =>
                Navigator.of(context).push(BasePage.createModalRoute(RouteNames.comments.name, arguments: artworkId)),
          ),
        ),
      ],
    );
  }
}

class _CommentItem extends ConsumerWidget {
  const _CommentItem({
    required this.comment,
  });

  final Comments comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 作者头像
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: ClipOval(
                  child: EnhanceNetworkImage(
                    image: ExtendedNetworkImageProvider(
                      HttpHostOverrides().pxImgUrl(comment.user.profileImageUrls.medium),
                      headers: HttpHostOverrides().dynamicHeaders(comment.user.profileImageUrls.medium),
                    ),
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              // 昵称
              Expanded(
                flex: 1,
                child: Text(
                  comment.user.name,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(color: textTheme.titleMedium?.color?.withAlpha(200)),
                ),
              ),
              // 发布时间
              Text(
                formatDate(comment.date.toLocal(), [yyyy, '-', mm, '-', dd]),
                style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
          // 评论内容
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Builder(builder: (context) {
              // 表情内容
              if (comment.stamp != null) {
                return EnhanceNetworkImage(
                  image: ExtendedNetworkImageProvider(
                    HttpHostOverrides().pxImgUrl(comment.stamp!.stampUrl),
                    headers: HttpHostOverrides().dynamicHeaders(comment.stamp!.stampUrl),
                  ),
                  height: 50,
                );
              }
              // 文字内容
              return Text(
                comment.comment,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium
                    ?.copyWith(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
              );
            }),
          ),
        ],
      ),
    );
  }
}
