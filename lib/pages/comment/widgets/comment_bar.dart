import 'dart:math';

import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/buttons/label_button.dart';
import 'package:artvier/component/content/expansion_custom.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/pages/comment/provider/comment_bar_provider.dart';
import 'package:artvier/pages/comment/provider/comment_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommentsBar extends BaseStatefulPage {
  const CommentsBar({
    super.key,
    required this.worksId,
    required this.expansionCustomController,
    required this.textController,
    required this.focusNode,
  });

  /// 作品id
  final String worksId;

  final ExpansionCustomController expansionCustomController;

  final TextEditingController textController;

  final FocusNode focusNode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CommentsBarState();
  }
}

class _CommentsBarState extends BasePageState<CommentsBar> {
  String get worksId => widget.worksId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Column(
        children: [
          ValueListenableBuilder<double>(
            valueListenable: widget.expansionCustomController.progress,
            builder: (BuildContext context, progress, Widget? child) {
              final content = Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    LabelButton(
                      onPressed: () {
                        if (!widget.expansionCustomController.isExpanded) {
                          widget.focusNode.unfocus();
                        }
                        widget.expansionCustomController.toggle();
                      },
                      padding: const EdgeInsets.all(6.0),
                      child: const Icon(Icons.tag_faces_outlined),
                    ),
                    // 输入框
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.only(top: 7, left: 12, right: 12, bottom: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 回复框
                            Consumer(builder: (context, ref, child) {
                              final model = ref.watch(commentBarProvider(widget.worksId));
                              return model.parentCommentId == null || model.parentCommentName == null
                                  ? const SizedBox()
                                  : Container(
                                      margin: const EdgeInsets.only(bottom: 4),
                                      padding: const EdgeInsets.only(top: 2, left: 8, right: 4, bottom: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${l10n.reply} @${model.parentCommentName}: ",
                                              style: textTheme.labelSmall,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              final state = ref
                                                  .read(commentBarProvider(widget.worksId))
                                                  .copyWith(parentCommentId: null, parentCommentName: null);
                                              ref.read(commentBarProvider(widget.worksId).notifier).update(state);
                                            },
                                            child: Container(
                                              color: Colors.transparent,
                                              padding: const EdgeInsets.all(8.0),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.withOpacity(0.1),
                                                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          textTheme.bodyMedium?.color?.withOpacity(0.5) ?? Colors.grey),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Icon(Icons.close,
                                                      size: 10, color: textTheme.bodyMedium?.color ?? Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                            }),
                            TextField(
                              autofocus: false,
                              focusNode: widget.focusNode,
                              controller: widget.textController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              style: const TextStyle(fontSize: 14),
                              minLines: 1,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: "${l10n.search}...",
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                isCollapsed: true, // 高度包裹，不会存在默认高度
                                alignLabelWithHint: true,
                                suffix: ValueListenableBuilder<TextEditingValue>(
                                  valueListenable: widget.textController,
                                  builder: (BuildContext context, value, Widget? child) => Text(
                                    '${value.text.length}/140',
                                    style: textTheme.labelSmall
                                        ?.copyWith(color: textTheme.labelSmall?.color?.withOpacity(0.5)),
                                  ),
                                ),
                                isDense: true,
                              ),
                              onSubmitted: (value) {},
                              onChanged: (value) {
                                if (value.length > 140) widget.textController.text = value.substring(0, 140);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 发布按钮
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: widget.textController,
                      builder: (BuildContext context, value, Widget? child) {
                        bool isEmpty = value.text.trim().isEmpty;
                        bool isSending = ref.watch(commentBarProvider(worksId).select((value) => value.isSending));
                        return LabelButton(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          disabled: isEmpty || isSending,
                          background:
                              (isEmpty || isSending) ? colorScheme.primary.withOpacity(0.2) : colorScheme.primary,
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          onPressed: () {
                            final model = ref.read(commentBarProvider(worksId));
                            final notifier = ref.read(commentBarProvider(worksId).notifier);
                            notifier.update(model.copyWith(isSending: true));
                            ref
                                .read(commentBarProvider(worksId).notifier)
                                .sendOrReply(comment: widget.textController.text)
                                .then((value) {
                              Fluttertoast.showToast(msg: l10n.sendSuccess);
                              if (model.parentCommentId != null) {
                                // 回复
                                ref
                                    .read(commentListProvider(worksId).notifier)
                                    .setReply(model.parentCommentId!, hasReplies: true);
                              } else {
                                // 评论
                                ref.read(commentListProvider(worksId).notifier).insetFirst(value);
                              }
                              widget.textController.text = '';
                            }).catchError((_, __) {
                              Fluttertoast.showToast(msg: l10n.sendFailed);
                            }).whenComplete(() => notifier.update(model.copyWith(isSending: false)));
                          },
                          child: Text(l10n.send,
                              style: isEmpty
                                  ? textTheme.labelLarge?.copyWith(color: colorScheme.primary.withOpacity(0.5))
                                  : textTheme.labelLarge?.copyWith(color: colorScheme.onPrimary)),
                        );
                      },
                    ),
                  ],
                ),
              );
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom * (1 - progress)),
                child: content,
              );
            },
          ),
          ExpansionCustom(
            controller: widget.expansionCustomController,
            initialExpanded: false,
            maxHeight: min(MediaQueryData.fromView(View.of(context)).size.height / 2, 250),
            minHeight: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Divider(height: 0.5, color: Colors.grey.withOpacity(0.5)),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                        left: 12.0,
                        right: 12,
                        top: 12,
                        bottom: MediaQueryData.fromView(View.of(context)).padding.bottom),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                    itemBuilder: (context, index) {
                      final entry = CONSTANTS.emojiMap.entries.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          widget.textController.text = "${widget.textController.text}(${entry.value})";
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Image.asset(
                              "assets/emoji/${entry.key}.png",
                              filterQuality: FilterQuality.high,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: CONSTANTS.emojiMap.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
