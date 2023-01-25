import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/pages/search/result/arguments/seach_filter_arguments.dart';
import 'package:pixgem/pages/search/result/provider/search_filters_provider.dart';

class SearchFilterBottomSheet extends ConsumerStatefulWidget {
  const SearchFilterBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends ConsumerState<SearchFilterBottomSheet> with _Logic {
  /// 将筛选参数变为局部变量
  // SearchFilterArguments get _arguments => ref.read(searchFilterProvider).copyWith();

  /// 最小收藏数的选择项
  final List<int> _minCollectList = const [
    0,
    500,
    1000,
    5000,
    10000,
    20000,
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Builder(
          builder: (context) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Consumer(builder: (_, ref, __) {
                    var data = ref.watch(filterProvider.select((value) => value.minCollectCount));
                    return Text("收藏超过${data ?? _minCollectList[0]}的插画");
                  }),
                ),
                Consumer(builder: (_, ref, __) {
                  var data = ref.watch(filterProvider.select((value) => value.minCollectCount));
                  return Slider(
                    min: 0,
                    max: _minCollectList.length.roundToDouble() - 1,
                    label: data?.toString() ?? _minCollectList[0].toString(),
                    onChanged: (double value) {
                      int index = value.round();
                      ref
                          .read(filterProvider.notifier)
                          .update((state) => state.copyWith(minCollectCount: _minCollectList[index]));
                    },
                    divisions: _minCollectList.length - 1,
                    value: _minCollectList.indexOf(data ?? _minCollectList[0]).toDouble(),
                  );
                }),
              ],
            );
          },
        ),
        // 取消按钮
        Container(
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.only(top: 8),
          child: CupertinoButton(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.zero,
            onPressed: handlePressedConform,
            child: Text(
              "确定",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}

mixin _Logic on ConsumerState<SearchFilterBottomSheet> {
  /// 筛选
  final filterProvider = StateProvider.autoDispose<SearchFilterArguments>((ref) => ref.read(searchFilterProvider));

  /// 确认筛选
  void handlePressedConform() {
    Navigator.of(context).pop(ref.read(filterProvider));
  }
}
