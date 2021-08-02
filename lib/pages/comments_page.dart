import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';
import 'package:pixgem/request/api_app.dart';
import 'package:pixgem/widgets/comment.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  final String illustId; // 作品id

  CommentsPage({Key? key, required this.illustId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommentsPageState();
  }
}

class _CommentsPageState extends State<CommentsPage> {
  _IllustCommentsProvider _providerComments = new _IllustCommentsProvider();
  int _page = 0; // 页码

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _providerComments,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Consumer(
            builder: (BuildContext context, _IllustCommentsProvider provider, Widget? child) {
              String count = provider.count < 0 ? "loading..." : provider.count.toString();
              return Text.rich(
                TextSpan(
                  text: "总评论数：",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  children: [
                    TextSpan(text: count),
                  ],
                ),
              );
            },
          ),
          // backgroundColor: Colors.transparent,
          // shadowColor: Colors.transparent,
          brightness: Brightness.dark, // 状态栏亮度，对应影响到字体颜色（dark为白色字体）
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }),
        ),
        body: Consumer(
          builder: (BuildContext context, _IllustCommentsProvider provider, Widget? child) {
            if (provider.isLoading) {
              return _buildLoading(context);
            }
            return ListView.builder(
              itemCount: provider.commentList.length,
              itemBuilder: (BuildContext context, int index) {
                // 如果滑动到了表尾
                if (index == provider.commentList.length - 1) {
                  // 未到列表上限，继续获取数据
                  if (provider.commentList.length < provider.count) {
                    requestNextPageData();
                    //加载时显示loading
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
                    );
                  } else {
                    //已经加载完全部数据，不再获取
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ));
                  }
                }
                // 非表尾的情况下显示列表项
                return Container(
                  padding: EdgeInsets.only(left: 6),
                  child: CommentWidget(
                    imageUrl: provider.commentList[index].user.profileImageUrls.medium,
                    name: provider.commentList[index].user.name,
                    content: provider.commentList[index].comment,
                    time: provider.commentList[index].date,
                    // stampId: provider.commentList[index].id.toString(),
                    couldReply: true,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
    );
  }

  @override
  void initState() {
    super.initState();
    requestNextPageData();
  }

  // 请求获取下一页的数据
  void requestNextPageData() {
    ApiApp().getIllustComments(illustId: widget.illustId).then((value) {
      print("request");
      _page++; // 页码更新到下一页
      _providerComments.setAll( newComments: value.comments, count: value.comments.length, isLoading: false); // 设置provider(重复同数据不会进行通知）
    }).catchError((onError) {
      print(onError.toString());
    });
  }
}

/* Provider: IllustComments
 */
class _IllustCommentsProvider with ChangeNotifier {
  List<Comments> commentList = []; // UI渲染的评论列表

  bool isLoading = true; // 是否正在加载（仅用于加载第一页时）
  int count = -1; // 总评论数

  void setAll({required newComments, required isLoading, required count}) {
    commentList.addAll(newComments);
    if (this.isLoading != isLoading) {
      this.isLoading = isLoading;
    }
    if (this.count != count) {
      this.count = count;
    }
    notifyListeners();
  }

  void addComments(List<Comments> comments) {
    commentList.addAll(comments);
    notifyListeners();
  }

  void setIsLoading(bool value) {
    // 值改变了才进行通知
    if (isLoading != value) {
      isLoading = value;
      notifyListeners();
    }
  }

  void setCommentCount(int value) {
    // 值改变了才进行通知
    if (count != value) {
      count = value;
      notifyListeners();
    }
  }
}
