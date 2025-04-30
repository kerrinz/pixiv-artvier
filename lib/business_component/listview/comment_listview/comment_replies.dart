import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_listview_item.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_replies_listview.dart';
import 'package:artvier/business_component/listview/comment_listview/logic.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/bottom_sheet/close_bar.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/component/content/expansion_custom.dart';
import 'package:artvier/component/loading/lazyloading.dart';
import 'package:artvier/component/scroll_physics/top_clamping_bouncing_scroll_physics.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:artvier/pages/comment/provider/comment_bar_provider.dart';
import 'package:artvier/pages/comment/widgets/comment_bar_bottom_sheet.dart';
import 'package:artvier/pages/comment/widgets/comment_bar_preview.dart';
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
  IllustComments? get cachedReplies => _cachedReplies;
  late final IllustComments? _cachedReplies;

  @override
  String get worksId => widget.worksId;

  int get parentCommentId => widget.comment.id;

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _expansionCustomController.collapse();
      }
    });
    _cachedReplies = widget.cachedReplies;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetSlideBar(),
          BottomSheetCloseBar(
            padding: const EdgeInsets.only(top: 4, left: 16.0, right: 16, bottom: 8),
            title: Text(l10n.commentDetails, style: textTheme.titleMedium),
            onTapClose: () => Navigator.of(context).pop(context),
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
                          onReply: () {
                            final commentBarNotifier = ref.read(commentBarProvider(worksId).notifier);
                            commentBarNotifier.enableReply(widget.comment.id, widget.comment.user.name);
                            showCommentsBarInput(true);
                            FocusScope.of(context).requestFocus(_focusNode);
                          },
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
                    child: Text(l10n.allReplies, style: textTheme.titleSmall),
                  ),
                ),
                Consumer(builder: (_, ref, __) {
                  final replies = ref.watch(commentRepliesProvider(parentCommentId));
                  final commentsRepliesNotifier = commentRepliesProvider(parentCommentId).notifier;
                  return replies.when(
                    data: (itemList) {
                      return SliverCommentRepliesListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        worksId: worksId,
                        commentList: itemList,
                        onLazyload: () async => ref.read(commentsRepliesNotifier).next(),
                        // 回复
                        onReply: (commentId, commentName) {
                          final commentBarNotifier = ref.read(commentBarProvider(worksId).notifier);
                          commentBarNotifier.enableReply(commentId, commentName);
                          showCommentsBarInput(true);
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
                                      ref
                                          .read(commentsRepliesNotifier)
                                          .handleDelete(commentId, parentCommentId)
                                          .then((value) {
                                        Fluttertoast.showToast(msg: l10n.deleteSuccess);
                                      }).catchError(
                                        (err) {
                                          logger.d(err);
                                          Fluttertoast.showToast(msg: l10n.deleteFailed).then((value) => null);
                                        },
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
          Consumer(
            builder: (context, ref, child) {
              ref.watch(commentBarProvider(widget.worksId));
              return CommentsBarPreview(
                text: "${l10n.reply} @${widget.comment.user.name}",
                onTapIcon: () {
                  _expansionCustomController.collapse();
                  ref
                      .read(commentBarProvider(widget.worksId).notifier)
                      .enableReply(widget.comment.id, widget.comment.user.name);
                  showCommentsBarInput(false);
                },
                onTapInput: () {
                  ref
                      .read(commentBarProvider(widget.worksId).notifier)
                      .enableReply(widget.comment.id, widget.comment.user.name);
                  showCommentsBarInput(true);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// Show Comments bar bottom sheet and focus input.
  showCommentsBarInput(bool initialFocusInput) {
    BottomSheets.showCustomBottomSheet<bool>(
        context: ref.context,
        exitOnClickModal: true,
        enableDrag: false,
        child: CommentsBarBottomSheet(
          worksId: worksId,
          expansionCustomController: _expansionCustomController,
          textController: _textController,
          focusNode: _focusNode,
          parentCommentId: widget.comment.id,
          parentCommentName: widget.comment.user.name,
          initialFocusInput: initialFocusInput,
          initialExpandStickers: !initialFocusInput,
          onSendMessage: (message, worksId, parentCommentId) {
            if (parentCommentId == null) {
              logger.e("CommentsBarBottomSheet: onSendMessage => parentCommentId is null");
            }
            final commentBarNotifier = ref.read(commentBarProvider(worksId).notifier);
            commentBarNotifier.setIsSending(true);
            return ref
                .read(commentRepliesProvider(parentCommentId!).notifier)
                .handleSendOrReply(parentCommentId: parentCommentId, message: message)
                .then((value) => Fluttertoast.showToast(msg: l10n.sendSuccess))
                .catchError((err, __) {
              Fluttertoast.showToast(msg: l10n.sendFailed);
              throw err;
            }).whenComplete(() => commentBarNotifier.setIsSending(false));
          },
          onSendSticker: (int stickerId, String worksId, int? parentCommentId) async {
            /// TODO: 发送贴图
          },
        ));
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _textController.dispose();
    _focusNode.dispose();
    ref.read(commentRepliesProvider(parentCommentId).notifier).updateCacheReplies();
    super.dispose();
  }
}
