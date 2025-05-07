import 'dart:math';

import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_replies.dart';
import 'package:artvier/component/buttons/label_button.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CommentListViewItem extends BasePage {
  const CommentListViewItem({
    super.key,
    required this.worksId,
    required this.comment,
    required this.onDelete,
    this.onReply,
    this.isDetailModal = false,
  });

  final String worksId;

  final Comments comment;

  final VoidCallback? onReply;

  final VoidCallback? onDelete;

  /// 是否处于模态框
  final bool isDetailModal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 作者头像
        Container(
          padding: const EdgeInsets.only(top: 12),
          child: ClipOval(
            child: EnhanceNetworkImage(
              image: ExtendedNetworkImageProvider(
                HttpHostOverrides().pxImgUrl(comment.user.profileImageUrls.medium),
                headers: HttpHostOverrides().dynamicHeaders(comment.user.profileImageUrls.medium),
              ),
              fit: BoxFit.cover,
              width: 48,
              height: 48,
            ),
          ),
        ),
        // 昵称 + 内容
        Expanded(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 昵称
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 8),
                        child: Text(
                          comment.user.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                // 内容
                Builder(builder: (context) {
                  if (comment.stamp != null) {
                    return EnhanceNetworkImage(
                      image: ExtendedNetworkImageProvider(
                        HttpHostOverrides().pxImgUrl(comment.stamp!.stampUrl),
                        headers: HttpHostOverrides().dynamicHeaders(comment.stamp!.stampUrl),
                      ),
                      width: 64,
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      comment.comment,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }),
                // 发布时间
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Text(
                          formatDate(
                            comment.date.toLocal(),
                            [yyyy, '-', mm, '-', dd, ' ', HH, ':', mm, ':', ss],
                          ),
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      // 回复/删除按钮
                      Builder(builder: (context) {
                        final account = ref.watch(globalCurrentAccountProvider);
                        return account?.user != null && account!.user.id == comment.user.id.toString()
                            ? LabelButton(
                                onPressed: onDelete,
                                child: Text(l10n(context).delete),
                              )
                            : LabelButton(
                                onPressed: onReply,
                                child: Text(l10n(context).reply),
                              );
                      }),
                    ],
                  ),
                ),
                if (comment.hasReplies && !isDetailModal)
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            CommentReplies(worksId: worksId, comment: comment, cachedReplies: comment.cacheReplies),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 4, bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 回复的用户和内容
                          for (final reply in comment.cacheReplies?.comments
                                  .sublist(0, min(comment.cacheReplies?.comments.length ?? 0, 5)) ??
                              [])
                            // 贴图回复内容
                            reply.stamp != null
                                ? Row(
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: reply.user.name,
                                              style: textTheme(context).bodyMedium?.copyWith(
                                                  color: colorScheme(context).primary, fontWeight: FontWeight.bold),
                                            ),
                                            const TextSpan(text: ': '),
                                          ],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      EnhanceNetworkImage(
                                        image: ExtendedNetworkImageProvider(
                                          HttpHostOverrides().pxImgUrl(reply.stamp!.stampUrl),
                                          headers: HttpHostOverrides().dynamicHeaders(reply.stamp!.stampUrl),
                                        ),
                                        width: 32,
                                      ),
                                    ],
                                  )
                                // 文本回复内容
                                : Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: reply.user.name,
                                          style: textTheme(context).bodyMedium?.copyWith(
                                              color: colorScheme(context).primary, fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(text: ': ${reply.comment}'),
                                      ],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          // 查看全部回复的提示文案
                          if ((comment.hasReplies && comment.cacheReplies == null) ||
                              (comment.cacheReplies?.comments.length ?? 0) >= 5 &&
                                  comment.cacheReplies?.nextUrl != null)
                            Row(
                              children: [
                                Text(l10n(context).viewReplies,
                                    style:
                                        textTheme(context).labelLarge?.copyWith(color: colorScheme(context).primary)),
                                Icon(Icons.keyboard_arrow_right, size: 18, color: colorScheme(context).primary),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
              ])),
        ),
      ],
    );
  }
}
