import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/pages/search/expand_search/widget/search_input.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 从搜索框完整展开后的搜索页
class ExpandSearchPage extends ConsumerStatefulWidget {
  const ExpandSearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpandSearchPageState();
}

class _ExpandSearchPageState extends BasePageState<ExpandSearchPage> {
  late final TextEditingController _textController;

  late final FocusNode _focusNode;

  @override
  void initState() {
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExtendedNestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: SliverWidgetPersistentHeaderDelegate(
                maxHeight: (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) +
                    MediaQuery.of(context).padding.top,
                minHeight: (Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight) +
                    MediaQuery.of(context).padding.top,
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, bottom: 10, left: 0, right: 0),
                  color: colorScheme.surface,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SearchInput(
                          focusNode: _focusNode,
                          textController: _textController,
                        ),
                      )),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(l10n.promptCancel),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        // 内容主体
        body: Consumer(
          builder: (_, ref, __) {
            return Container();
          },
        ),
      ),
    );
  }
}
