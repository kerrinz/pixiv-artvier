import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_listview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:artvier/pages/comment/provider/comment_list_provider.dart';

class CommentsPage extends BaseStatefulPage {
  /// 作品id
  final String worksId;

  const CommentsPage(Object arguments, {super.key})
      : worksId = arguments as String;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CommentsPageState();
  }
}

class _CommentsPageState extends BasePageState<CommentsPage> {
  String get worksId => widget.worksId;

  Refreshable<CommentsNotifier> get commentsNotifier => commentListProvider(worksId).notifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("全部评论"),
      ),
      body: Consumer(
        builder: ((context, ref, child) {
          var asyncData = ref.watch(commentListProvider(worksId));
          return asyncData.when(
            loading: () => const RequestLoading(),
            error: (Object error, StackTrace stackTrace) =>
                RequestLoadingFailed(onRetry: () async => ref.read(commentsNotifier).reload()),
            data: (List<Comments> comments) => RefreshIndicator(
              onRefresh: () => ref.read(commentsNotifier).refresh(),
              child: CommentListView(
                commentList: comments,
                onLazyload: () async => ref.read(commentsNotifier).next(),
              ),
            ),
          );
        }),
      ),
    );
  }
}
