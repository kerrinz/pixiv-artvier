import 'package:flutter/material.dart';
import 'package:pixgem/config/constants.dart';

class CommentWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String content;
  final String time;
  final String? stampId;
  final bool couldReply;

  CommentWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.content,
    required this.time,
    required this.couldReply,
    this.stampId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // 作者头像
        Container(
          padding: EdgeInsets.only(top: 12),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              width: 50,
              height: 50,
              headers: {"Referer": CONSTANTS.referer},
              fit: BoxFit.cover,
            ),
          ),
        ),
        // 昵称 + 内容
        Expanded(
          flex: 1,
          child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 昵称
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 8),
                        child: Text(
                          name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    // 回复按钮
                    Builder(builder: (context) {
                      if (couldReply)
                        return TextButton(
                          onPressed: () {},
                          child: Text("回复"),
                          // style: TextButton.styleFrom(primary: Colors.blue.shade400),
                        );
                      else
                        return Text("");
                    }),
                  ],
                ),
                // 内容
                Builder(builder: (context) {
                  if (stampId != null) {
                    return Image.network(
                      "${CONSTANTS.stamp_url_base}${stampId}_s.jpg",
                      width: 100,
                    );
                  }
                  return Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  );
                }),
                // 发布时间
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    time,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              ])),
        ),
      ],
    );
  }
}
