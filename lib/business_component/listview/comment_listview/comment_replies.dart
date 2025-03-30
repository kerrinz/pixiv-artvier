import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_listview_item.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_replies_listview.dart';
import 'package:artvier/business_component/listview/comment_listview/logic.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/component/content/expansion_custom.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/component/scroll_physics/top_clamping_bouncing_scroll_physics.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:artvier/pages/comment/provider/comment_bar_provider.dart';
import 'package:artvier/pages/comment/provider/comment_list_provider.dart';
import 'package:artvier/pages/comment/widgets/comment_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentReplies extends BaseStatefulPage {
  const CommentReplies({
    super.key,
    required this.worksId,
    required this.comment,
    this.cachedReplies,
  });

  /// 作品id
  final String worksId;

  final Comments comment;

  final IllustComments? cachedReplies;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CommentRepliesState();
  }
}

class _CommentRepliesState extends BasePageState<CommentReplies> with CommentRepliesLogic {
  late final TextEditingController _textController;

  late final FocusNode _focusNode;

  final ExpansionCustomController _expansionCustomController = ExpansionCustomController();

  @override
  IllustComments? get cachedReplies => widget.cachedReplies;

  @override
  String get worksId => widget.worksId;

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _expansionCustomController.collapse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetSlideBar(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text('评论详情', style: textTheme.titleMedium),
          ),
          Expanded(
            child: CustomScrollView(
              physics: const TopClampingBouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: CommentListViewItem(
                          worksId: worksId,
                          comment: widget.comment,
                          onDelete: () {},
                          isDetailModal: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                        child: Divider(color: Colors.grey.withOpacity(0.2)),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4, bottom: 0),
                    child: Text('全部回复', style: textTheme.titleSmall),
                  ),
                ),
                Consumer(builder: (_, ref, __) {
                  final replies = ref.watch(commentRepliesProvider(widget.comment.id));
                  final commentsRepliesNotifier = commentRepliesProvider(widget.comment.id).notifier;
                  return replies.when(
                    data: (itemList) {
                      return SliverCommentRepliesListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        worksId: worksId,
                        commentList: itemList,
                        onLazyload: () async => ref.read(commentsRepliesNotifier).next(),
                        // 回复
                        onReply: (commentId, commentName) {
                          /// TODO
                          // final state = ref
                          //     .read(commentBarProvider(worksId))
                          //     .copyWith(parentCommentId: commentId, parentCommentName: commentName);
                          // ref.read(commentBarProvider(worksId).notifier).update(state);
                          // _focusNode.requestFocus();
                          FocusScope.of(context).requestFocus(_focusNode);
                        },
                        // 删除
                        onDelete: (commentId) {
                          showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(l10n.promptTitle),
                                content: Text(l10n.promptDeleteComment),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(l10n.promptCancel),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      ref.read(commentBarProvider(worksId).notifier).delete(commentId).then((value) {
                                        Fluttertoast.showToast(msg: l10n.deleteSuccess);
                                        final value =
                                            ref.read(commentRepliesProvider(commentId).notifier).remove(commentId);
                                        if (value.isEmpty) {
                                          // 最后一条评论被删除
                                          ref
                                              .read(commentListProvider(worksId).notifier)
                                              .setReply(commentId, hasReplies: false);
                                        }
                                      }).catchError(
                                        (_, __) => Fluttertoast.showToast(msg: l10n.deleteFailed).then((value) => null),
                                      );
                                    },
                                    child: Text(l10n.promptConform),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => SliverToBoxAdapter(
                      child: Center(child: LazyloadingFailedWidget(onRetry: (() {
                        ref.read(commentsRepliesNotifier).reload();
                      }))),
                    ),
                    loading: (() => const SliverToBoxAdapter(child: Center(child: LazyloadingWidget()))),
                  );
                }),
              ],
            ),
          ),
          CommentsBar(
            worksId: worksId,
            expansionCustomController: _expansionCustomController,
            textController: _textController,
            focusNode: _focusNode,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
