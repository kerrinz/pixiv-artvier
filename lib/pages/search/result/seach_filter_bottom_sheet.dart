import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/pages/search/result/seach_filter_arguments.dart';

class SearchFilterBottomSheetWidget extends StatefulWidget {
  final SearchFilterArguments arguments;

  const SearchFilterBottomSheetWidget({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheetWidget> {
  late SearchFilterArguments _arguments;

  /// 最小收藏数的选择项
  final List<int> _minCollectList = const [
    0,
    500,
    1000,
    5000,
    10000,
    20000,
  ];
  double _sliderValue = 0;

  @override
  void initState() {
    _arguments = widget.arguments;
    _sliderValue = _minCollectList.indexOf(_arguments.minCollectCount ?? _minCollectList[0]).toDouble();
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
                  child: Text("收藏超过${_arguments.minCollectCount ?? _minCollectList[0]}的插画"),
                ),
                Slider(
                  min: 0,
                  max: _minCollectList.length.roundToDouble() - 1,
                  label: _arguments.minCollectCount?.toString() ?? _minCollectList[0].toString(),
                  onChanged: (double value) {
                    _sliderValue = value;
                    int index = value.round();
                    _arguments.minCollectCount = _minCollectList[index];
                    (context as Element).markNeedsBuild();
                  },
                  divisions: _minCollectList.length - 1,
                  value: _sliderValue,
                ),
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
            child: Text(
              "确定",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.of(context).pop(_arguments);
            },
          ),
        ),
      ],
    );
  }
}
