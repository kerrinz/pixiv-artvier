import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/content/expansion_custom.dart';
import 'package:artvier/pages/comment/provider/comment_bar_provider.dart';
import 'package:artvier/pages/comment/widgets/comment_bar_bottom_sheet.dart';
import 'package:artvier/pages/comment/widgets/comment_bar_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/listview/comment_listview/comment_listview.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/model_response/illusts/illust_comments.dart';
import 'package:artvier/pages/comment/provider/comment_list_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentsPage extends BaseStatefulPage {
  /// 作品id
  final String worksId;

  const CommentsPage(Object arguments, {super.key}) : worksId = arguments as String;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CommentsPageState();
  }
}

class _CommentsPageState extends BasePageState<CommentsPage> {
  String get worksId => widget.worksId;

  Refreshable<CommentsNotifier> get commentsNotifier => commentListProvider(worksId).notifier;

  late final TextEditingController _textController;

  late final FocusNode _focusNode;

  final ExpansionCustomController _expansionCustomController = ExpansionCustomController();

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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: const AppbarLeadingButtton(),
          titleSpacing: 0,
          title: Text(l10n.comments),
        ),
        body: CupertinoPageScaffold(
          child: Column(
            children: [
              Expanded(
                child: Consumer(
                  builder: ((context, ref, child) {
                    var asyncData = ref.watch(commentListProvider(worksId));
                    return asyncData.when(
                      loading: () => const RequestLoading(),
                      error: (Object error, StackTrace stackTrace) =>
                          RequestLoadingFailed(onRetry: () async => ref.read(commentsNotifier).reload()),
                      data: (List<Comments> comments) => RefreshIndicator(
                        onRefresh: () => ref.read(commentsNotifier).refresh(),
                        child: GestureDetector(
                          onTap: () {
                            _expansionCustomController.collapse();
                          },
                          child: CommentListView(
                            worksId: worksId,
                            commentList: comments,
                            onLazyload: () async => ref.read(commentsNotifier).next(),
                            // 回复
                            onReply: (commentId, commentName) {
                              _expansionCustomController.collapse();
                              showCommentsBarInput(true, commentId, commentName);
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
                                              .read(commentListProvider(worksId).notifier)
                                              .handleDelete(commentId)
                                              .then((value) {
                                            Fluttertoast.showToast(msg: l10n.deleteSuccess);
                                          }).catchError(
                                            (_, __) =>
                                                Fluttertoast.showToast(msg: l10n.deleteFailed).then((value) => null),
                                          );
                                        },
                                        child: Text(l10n.promptConform),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  ref.watch(commentBarProvider(widget.worksId));
                  return CommentsBarPreview(
                    text: "${l10n.commentHint}...",
                    onTapIcon: () {
                      _expansionCustomController.collapse();
                      ref.read(commentBarProvider(widget.worksId).notifier).disableReply();
                      showCommentsBarInput(false, null, null);
                    },
                    onTapInput: () {
                      _expansionCustomController.collapse();
                      ref.read(commentBarProvider(widget.worksId).notifier).disableReply();
                      showCommentsBarInput(true, null, null);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Show Comments bar bottom sheet and focus input.
  showCommentsBarInput(bool initialFocusInput, int? parentCommentId, String? parentCommentName) {
    final commentBarNotifier = ref.read(commentBarProvider(worksId).notifier);
    if (parentCommentId != null && parentCommentName != null) {
      commentBarNotifier.enableReply(parentCommentId, parentCommentName);
    } else {
      commentBarNotifier.disableReply();
    }
    BottomSheets.showCustomBottomSheet<bool>(
        context: ref.context,
        exitOnClickModal: true,
        enableDrag: false,
        child: CommentsBarBottomSheet(
          worksId: worksId,
          expansionCustomController: _expansionCustomController,
          textController: _textController,
          focusNode: _focusNode,
          parentCommentId: parentCommentId,
          parentCommentName: parentCommentName,
          initialFocusInput: initialFocusInput,
          initialExpandStickers: !initialFocusInput,
          onSendMessage: (message, worksId, parentCommentId) {
            final commentBarNotifier = ref.read(commentBarProvider(worksId).notifier);
            commentBarNotifier.setIsSending(true);
            return ref
                .read(commentListProvider(worksId).notifier)
                .handleSendOrReply(parentCommentId: parentCommentId, message: message)
                .then((value) {
              Fluttertoast.showToast(msg: l10n.sendSuccess);
            }).catchError((err, __) {
              Fluttertoast.showToast(msg: l10n.sendFailed);
              throw err;
            }).whenComplete(() => commentBarNotifier.setIsSending(false));
          },
          onSendSticker: (int stampId, String worksId, int? parentCommentId) async {
            _expansionCustomController.collapse();
            return ref
                .read(commentListProvider(worksId).notifier)
                .handleSendOrReply(parentCommentId: parentCommentId, stampId: stampId)
                .then((value) {
              Fluttertoast.showToast(msg: l10n.sendSuccess);
            }).catchError((err, __) {
              Fluttertoast.showToast(msg: l10n.sendFailed);
              throw err;
            });
          },
        ));
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
