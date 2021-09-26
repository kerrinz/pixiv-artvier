import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';
import 'package:pixgem/request/api_base.dart';
import 'package:pixgem/request/api_illusts.dart';
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
  IllustCommentsProvider _provider = new IllustCommentsProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "全部评论",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          leading: Builder(builder: (context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }),
        ),
        body: Consumer(
          builder: (BuildContext context, IllustCommentsProvider provider, Widget? child) {
            if (provider.commentList == null) {
              return _buildLoading(context);
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: provider.commentList!.length,
              itemBuilder: (BuildContext context, int index) {
                // 如果滑动到了表尾
                if (index == provider.commentList!.length - 1) {
                  // 未到上限，继续获取下一页数据
                  if (provider.nextUrl != null) {
                    requestNext();
                    //加载时显示loading
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).accentColor),
                      ),
                    );
                  } else {
                    //已经加载完全部数据，不再获取
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "没有更多了",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                }
                // 非表尾的情况下显示列表项
                return Container(
                  padding: EdgeInsets.only(left: 6),
                  child: CommentWidget(comment: provider.commentList![index]),
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
      child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).colorScheme.secondary)),
    );
  }

  @override
  void initState() {
    super.initState();
    refresh().catchError((onError) {
      Fluttertoast.showToast(msg: "加载失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
    });
  }

  Future refresh() async {
    var result = await ApiIllusts().getIllustComments(illustId: widget.illustId);
    _provider.setAll(result.comments, result.nextUrl);
  }

  // 获取下一页的数据
  Future requestNext() async {
    var res = await ApiBase().getNextUrlData(nextUrl: _provider.nextUrl!);
    var result = IllustComments.fromJson(res);
    _provider.addCommentList(result.comments);
    _provider.setNextUrl(result.nextUrl);
  }
}

/* Provider: IllustComments
 */
class IllustCommentsProvider with ChangeNotifier {
  List<Comments>? commentList; // 评论列表
  String? nextUrl;

  void setAll(List<Comments>? commentList, String? nextUrl) {
    this.commentList = commentList;
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  void setCommentList(List<Comments> commentList) {
    this.commentList = commentList;
    notifyListeners();
  }

  void addCommentList(List<Comments> commentList) {
    this.commentList = [...this.commentList ?? [], ...commentList];
    notifyListeners();
  }

  void setNextUrl(String? nextUrl) {
    this.nextUrl = nextUrl;
    notifyListeners();
  }
}
