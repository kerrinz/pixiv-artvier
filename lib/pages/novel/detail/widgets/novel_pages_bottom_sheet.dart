import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/bottom_sheet/close_bar.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/novels/novel_detail_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef NovelCatalogCallback = void Function(int index, String name);

/// 小说章节分页
class NovelPagesBottomSheet extends ConsumerStatefulWidget {
  const NovelPagesBottomSheet({
    super.key,
    required this.novel,
    required this.webViewData,
    this.callback,
  });

  final CommonNovel novel;
  final NovelDetailWebView webViewData;
  final NovelCatalogCallback? callback;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NovelPagesBottomSheetState();
}

class _NovelPagesBottomSheetState extends BasePageState<NovelPagesBottomSheet> {
  List<String> pages = [];

  @override
  void initState() {
    final lines = widget.webViewData.text.split('\n');
    pages.add('homepage');
    for (final line in lines) {
      final chapterMatch = RegExp(r'\[chapter:([^\n\]]+)\]').firstMatch(line);
      if (line.startsWith('[chapter') && (chapterMatch?.groupCount ?? 0) > 0) {
        final text = chapterMatch?.group(1);
        if (text != null) pages.add(text);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3 * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomSheetCloseBar(
            title: Text(l10n.catalog, style: textTheme.titleMedium),
            onTapClose: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(left: 12, right: 12, top: 0, bottom: MediaQuery.paddingOf(context).bottom + 16),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final text = index == 0 ? l10n.navHome : pages.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: listItem(
                    context: context,
                    text: index == 0 ? l10n.navHome : text,
                    icon: const Icon(Icons.link_rounded),
                    onTap: () {
                      if (widget.callback != null) widget.callback!(index, text);
                    },
                  ),
                );
              },
              itemCount: pages.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem({required context, required void Function()? onTap, required String text, required Widget icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        ),
        padding: const EdgeInsets.all(12),
        child: Text(text),
      ),
    );
  }
}
