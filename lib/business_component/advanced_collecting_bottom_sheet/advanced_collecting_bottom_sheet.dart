import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/logic.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/provider/collecting_provider.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/widget/tag_list_item_widget.dart';
import 'package:artvier/component/filter/stateless_flow_filter.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/l10n/localization_intl.dart';

/// 高级收藏的弹窗，支持插画漫画小说
class AdvancedCollectingBottomSheet extends ConsumerStatefulWidget {
  /// 是否已经收藏了
  final bool isCollected;

  /// 作品id
  final String worksId;

  /// 作品类型，仅支持[WorksType.illust],[WorksType.manga],[WorksType.novel]
  final WorksType worksType;

  /// 最大选择标签数
  static const maxSelectedTags = 10;

  const AdvancedCollectingBottomSheet({
    super.key,
    required this.isCollected,
    required this.worksId,
    required this.worksType,
  }) : assert(
          worksType == WorksType.illust || worksType == WorksType.novel,
          "Only support for illust and novel, manga must be replaced by illust.",
        );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdvancedCollectingBottomSheetState();
}

class _AdvancedCollectingBottomSheetState extends ConsumerState<AdvancedCollectingBottomSheet>
    with AdvancedCollectingBottomSheetLogic {
  /// 添加新标签的输入控制器
  late TextEditingController _addTagTextController;

  late FocusNode _addTagFocusNode;

  int get maxSelectedTags => AdvancedCollectingBottomSheet.maxSelectedTags;

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  @override
  String get worksId => widget.worksId;

  @override
  WorksType get worksType => widget.worksType;

  @override
  bool get isCollected => widget.isCollected;

  @override
  get addTagTextController => _addTagTextController;

  /// 键盘是否激活状态
  bool isKeyboardActived = false;

  @override
  void initState() {
    _addTagTextController = TextEditingController();
    _addTagFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _addTagFocusNode.unfocus();
    _addTagFocusNode.dispose();
    _addTagTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _layout(
      child: Column(
        children: [
          // 顶部操作栏
          Consumer(builder: (_, ref, __) {
            var collectState = worksType == WorksType.novel
                ? ref.watch(novelAdvancedCollectingProvider(worksId))
                : ref.watch(artworkAdvancedCollectingProvider(worksId));
            return _topHeader(collectState == null ? widget.isCollected : collectState == CollectState.collected);
          }),
          Expanded(
            child: Consumer(builder: ((context, ref, child) {
              return ref.watch(statesProvider).when(
                  data: (data) {
                    return Column(
                      children: [
                        // restrict / 隐私限制
                        _restrictSelection(),
                        // 分隔线
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                          decoration: BoxDecoration(color: colorScheme.surfaceContainerHighest),
                          child: const SizedBox(height: 2, width: double.infinity),
                        ),
                        // 附加标签标题栏
                        _attachTagsHeader(),
                        // 输入添加新的标签
                        _inputNewTagWidget(),
                        // 标签列表
                        Expanded(
                          flex: 1,
                          child: _tagListView(),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => RequestLoadingFailed(
                        onRetry: () => ref.read(statesProvider.notifier).reload(),
                      ),
                  loading: () => const RequestLoading());
            })),
          ),
        ],
      ),
    );
  }

  /// 基础布局
  Widget _layout({required Widget child}) {
    Size mediaSize = MediaQuery.of(context).size;
    double height = mediaSize.height * 0.6;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: mediaSize.width > mediaSize.height ? mediaSize.height : height,
      ),
      child: SafeArea(
        child: child,
      ),
    );
  }

  Widget _topHeader(bool isCollected) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context, null),
          icon: const Icon(Icons.close_rounded),
        ),
        Expanded(
          child: Center(
            child: Builder(builder: (context) {
              return Text(isCollected
                  ? LocalizationIntl.of(context).editCollection
                  : LocalizationIntl.of(context).addToCollections);
            }),
          ),
        ),
        IconButton(
          onPressed: handlePressedCollecting,
          icon: Row(
            children: [
              Icon(isCollected ? Icons.check_outlined : Icons.favorite_outline_rounded),
            ],
          ),
        ),
      ],
    );
  }

  Widget _attachTagsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocalizationIntl.of(context).attachTags,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          // 统计已选择的标签数量
          Consumer(builder: ((context, ref, child) {
            var tags = ref.watch(statesProvider.select((value) => value.value!.tags));
            int countSelected =
                tags.fold<int>(0, (previousValue, element) => previousValue + (element.isRegistered ?? false ? 1 : 0));
            return Text(
              "$countSelected / $maxSelectedTags",
              style: countSelected >= maxSelectedTags
                  ? TextStyle(color: colorScheme.tertiary, fontWeight: FontWeight.bold)
                  : null,
            );
          })),
        ],
      ),
    );
  }

  Widget _restrictSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocalizationIntl.of(context).privacyRestrict,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Consumer(builder: (_, ref, __) {
              var restrict = ref.watch(statesProvider.select((value) => value.value!.restrict));
              return StatelessTextFlowFilter(
                selectedDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: colorScheme.primary,
                ),
                unselectedTextStyle: TextStyle(color: colorScheme.onSurfaceVariant.withAlpha(200)),
                texts: [LocalizationIntl.of(context).public, LocalizationIntl.of(context).private],
                textPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                initialIndexes: {Restrict.public == restrict ? 0 : 1},
                onTap: handleTapRestrictSelection,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _inputNewTagWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: TextField(
        controller: _addTagTextController,
        focusNode: _addTagFocusNode,
        maxLines: 1,
        scrollPadding: EdgeInsets.zero,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          hintText: LocalizationIntl.of(context).addNewTagPlaceholder,
          hintMaxLines: 1,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isCollapsed: true, // 高度包裹，不会存在默认高度
        ),
        onSubmitted: ((value) {
          _addTagFocusNode.unfocus();
          handleSubmittedAddTag();
        }),
      ),
    );
  }

  Widget _tagListView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      child: Consumer(builder: (context, ref, _) {
        var tags = ref.watch(statesProvider.select((value) => value.value!.tags));
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (itemContext, index) => TagListItemWidget(
            name: tags[index].name ?? "",
            isRegistered: tags[index].isRegistered ?? false,
            onTap: () => handleTapTagsItem(index, tags),
          ),
          itemCount: tags.length,
        );
      }),
    );
  }
}
