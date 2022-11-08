import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';

class CommentWidget extends StatelessWidget {
  final Comments comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                comment.user.profileImageUrls.medium,
                headers: const {"Referer": CONSTANTS.referer},
              ),
              fit: BoxFit.cover,
              width: 50,
              height: 50,
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
                    // 回复按钮
                    Builder(builder: (context) {
                      return TextButton(
                        onPressed: () {},
                        child: const Text("回复"),
                        // style: TextButton.styleFrom(primary: Colors.blue.shade400),
                      );
                    }),
                  ],
                ),
                // 内容
                Builder(builder: (context) {
                  if (comment.stamp != null) {
                    return EnhanceNetworkImage(
                      image: ExtendedNetworkImageProvider(
                        comment.stamp!.stampUrl,
                        headers: const {"Referer": CONSTANTS.referer},
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
                    comment.date,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ])),
        ),
      ],
    );
  }
}
