import 'dart:math';

import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/buttons/label_button.dart';
import 'package:artvier/component/content/expansion_custom.dart';
import 'package:artvier/config/constants.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/pages/comment/provider/comment_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef SendStickerCallback = Future Function(int stickerId, String worksId, int? parentCommentId);
typedef SendMessageCallback = Future Function(String message, String worksId, int? parentCommentId);

class CommentsBarBottomSheet extends BaseStatefulPage {
  const CommentsBarBottomSheet({
    super.key,
    required this.worksId,
    required this.expansionCustomController,
    required this.textController,
    required this.focusNode,
    required this.onSendSticker,
    required this.onSendMessage,
    this.parentCommentId,
    this.parentCommentName,
    this.initialFocusInput = false,
    this.initialExpandStickers = false,
  });

  /// 作品id
  final String worksId;

  /// Use in comment replies.
  final int? parentCommentId;

  /// Use in comment replies.
  final String? parentCommentName;

  final ExpansionCustomController expansionCustomController;

  final TextEditingController textController;

  final FocusNode focusNode;

  final bool initialFocusInput;

  final bool initialExpandStickers;

  final SendStickerCallback onSendSticker;
  final SendMessageCallback onSendMessage;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CommentsBarBottomSheetState();
  }
}

class _CommentsBarBottomSheetState extends BasePageState<CommentsBarBottomSheet> {
  String get worksId => widget.worksId;

  @override
  void initState() {
    if (widget.initialFocusInput) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.focusNode.requestFocus();
      });
    }
    if (widget.initialExpandStickers) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.expansionCustomController.expand();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        children: [
          ValueListenableBuilder<double>(
            valueListenable: widget.expansionCustomController.progress,
            builder: (BuildContext context, progress, Widget? child) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom * (1 - progress)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      stickersButton(),
                      Expanded(
                        flex: 1,
                        child: inputBox(),
                      ),
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
                              // Send message
                              if (widget.textController.text == '') {
                                logger.e("Send empty or null message.");
                                return;
                              }
                              widget
                                  .onSendMessage(widget.textController.text, worksId, widget.parentCommentId)
                                  .then((value) {
                                widget.textController.text = '';
                              });
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
                ),
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

  Widget stickersButton() {
    return LabelButton(
      onPressed: () {
        if (!widget.expansionCustomController.isExpanded) {
          widget.focusNode.unfocus();
        } else {
          widget.focusNode.requestFocus();
        }
        widget.expansionCustomController.toggle();
      },
      padding: const EdgeInsets.all(6.0),
      child: const Icon(Icons.tag_faces_outlined),
    );
  }

  Widget inputBox() {
    // 输入框
    return Container(
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
                    padding: const EdgeInsets.only(top: 4, left: 8, right: 6, bottom: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Wrap(
                      children: [
                        Text(
                          "${l10n.reply} @${model.parentCommentName}: ",
                          style: textTheme.labelSmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
            style: textTheme.bodyMedium,
            minLines: 1,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "${l10n.commentHint}...",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isCollapsed: true, // 高度包裹，不会存在默认高度
              alignLabelWithHint: true,
              suffix: ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.textController,
                builder: (BuildContext context, value, Widget? child) => Text(
                  '${value.text.length}/140',
                  style: textTheme.labelSmall?.copyWith(color: textTheme.labelSmall?.color?.withOpacity(0.5)),
                ),
              ),
              isDense: true,
              hintStyle: textTheme.bodySmall?.copyWith(color: textTheme.labelSmall?.color?.withOpacity(0.5)),
            ),
            onSubmitted: (value) {},
            onChanged: (value) {
              if (value.length > 140) widget.textController.text = value.substring(0, 140);
            },
          ),
        ],
      ),
    );
  }
}
