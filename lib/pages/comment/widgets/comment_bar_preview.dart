import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/buttons/label_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentsBarPreview extends BaseStatefulPage {
  const CommentsBarPreview({
    super.key,
    this.onTapInput,
    this.onTapIcon,
  });

  final VoidCallback? onTapInput;

  final VoidCallback? onTapIcon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CommentsBarPreviewState();
  }
}

class _CommentsBarPreviewState extends BasePageState<CommentsBarPreview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            stickersButton(),
            Expanded(
              flex: 1,
              child: unactivedInputBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget stickersButton() {
    return LabelButton(
      onPressed: widget.onTapIcon,
      padding: const EdgeInsets.all(6.0),
      child: const Icon(Icons.tag_faces_outlined),
    );
  }

  Widget unactivedInputBox() {
    return GestureDetector(
      onTap: widget.onTapInput,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.only(top: 7, left: 12, right: 12, bottom: 9),
        child: Text("${l10n.comments}...",
            style: textTheme.bodyMedium?.copyWith(color: textTheme.bodyMedium?.color?.withOpacity(0.75))),
      ),
    );
  }
}
