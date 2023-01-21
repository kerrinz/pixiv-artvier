import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/base/base_page.dart';
import 'package:pixgem/business_component/listview/comment_listview/comment_listview.dart';
import 'package:pixgem/component/loading/request_loading.dart';
import 'package:pixgem/model_response/illusts/illust_comments.dart';
import 'package:pixgem/pages/comment/provider/comment_list_provider.dart';

class CommentsPage extends BaseStatefulPage {
  /// 作品id
  final String worksId;

  const CommentsPage(Object arguments, {Key? key})
      : worksId = arguments as String,
        super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CommentsPageState();
  }
}

class _CommentsPageState extends BasePageState<CommentsPage> {
  ScrollController scrollController = ScrollController();

  String get worksId => widget.worksId;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        var asyncData = ref.watch(commentListProvider(worksId));
        return asyncData.when(
          loading: () => const RequestLoading(),
          error: (Object error, StackTrace stackTrace) => RequestLoadingFailed(onRetry: () {}),
          data: (List<Comments> comments) => RefreshIndicator(
            onRefresh: () => ref.read(commentListProvider(worksId).notifier).refresh(),
            child: CommentListView(
              commentList: comments,
              onLazyload: () async => ref.read(commentListProvider(worksId).notifier).next(),
            ),
          ),
        );
      }),
    );
  }
}
