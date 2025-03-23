import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/buttons/label_button.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:date_format/date_format.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';

class CommentListViewItem extends BasePage {
  const CommentListViewItem({
    super.key,
    required this.comment,
    required this.onDelete,
    this.onReply,
  });

  final Comments comment;

  final VoidCallback? onReply;

  final VoidCallback? onDelete;

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
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    formatDate(
                      comment.date.toLocal(),
                      [yyyy, '-', mm, '-', dd, ' ', HH, ':', mm, ':', ss],
                    ),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ])),
        ),
      ],
    );
  }
}
