import 'package:flutter/material.dart';

typedef DropDownMenuListenerCallback = void Function();
typedef DropDownMenuChangeCallback = void Function(int index, String? value);
typedef DropDownMenuExpandCallback = void Function(int index, bool expanded);

class CategoryModel {
  String value;
  String name;
  bool check;

  CategoryModel({
    required this.value,
    required this.name,
    required this.check,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      value: json['Value'] as String,
      name: json['Name'] as String,
      check: json['Check'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['VALUE'] = value;
    data['Name'] = name;
    data['Check'] = check;
    return data;
  }
}

class DropDownMenuModel {
  String? name;
  String? id;
  String? defaultValue;
  List<CategoryModel> list = [];

  String get selectText {
    if (list.isEmpty) return "";
    try {
      return list.firstWhere((element) => element.value != '' && element.check == true).name;
    } catch (e) {
      return "";
    }
  }

  // String get selectValue {
  //   if (list.isEmpty) return "";
  //   try {
  //     return list.firstWhere((element) => element.value != '' && element.check == true).value;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  DropDownMenuModel({
    this.name,
    this.id,
    this.defaultValue,
    required this.list,
  });
}

class DropDownMenuExpandIndex extends ChangeNotifier {
  // 已展开菜单的索引，-1为无
  late int _expandedIndex;
  int get index => _expandedIndex;

  DropDownMenuExpandIndex({
    int expandedIndex = -1,
  }) {
    _expandedIndex = expandedIndex;
  }

  setExpandedIndex(int index) {
    _expandedIndex = index;
    notifyListeners();
  }

  @override
  notifyListeners() {
    super.notifyListeners();
  }

  /// 关闭已展开的菜单
  closeExpanded() {
    if (_expandedIndex != -1) {
      _expandedIndex = -1;
      notifyListeners();
    }
  }
}

class DropDownMenuSelectValues extends ChangeNotifier {
  // List<String> 为多选选项
  late List<List<String>> _selectedValues;
  List<List<String>> get values => _selectedValues;

  DropDownMenuSelectValues({
    required List<List<String>> selectedValues,
    int expandedIndex = -1,
  }) {
    _selectedValues = selectedValues;
  }

  setAllSelectedValues(List<List<String>> selectedValues) {
    _selectedValues = selectedValues;
    notifyListeners();
  }

  setMenuSelectedValues(int menuIndex, List<String> selectedValueList) {
    _selectedValues[menuIndex] = selectedValueList;
    notifyListeners();
  }

  @override
  notifyListeners() {
    super.notifyListeners();
  }
}

class DropDownMenuController {
  Iterable<DropDownMenuExpandIndex> get indexList => _indexList;
  final List<DropDownMenuExpandIndex> _indexList = <DropDownMenuExpandIndex>[];

  bool isExpanded() {
    return _indexList.indexWhere((element) => element.index > -1) > -1;
  }

  void closeMenu() {
    for (var status in _indexList) {
      status.closeExpanded();
    }
  }

  void attach(DropDownMenuExpandIndex status) {
    assert(!_indexList.contains(status));
    _indexList.add(status);
  }

  void detach(DropDownMenuExpandIndex status) {
    assert(_indexList.contains(status));
    _indexList.remove(status);
  }
}

///
class DropDownMenu extends StatefulWidget {
  const DropDownMenu({
    super.key,
    required this.filterList,
    this.layerLink,
    this.padding,
    this.controller,
    this.onExpand,
    this.onChange,
  });

  final List<DropDownMenuModel> filterList;

  final EdgeInsets? padding;

  final DropDownMenuController? controller;

  final DropDownMenuExpandCallback? onExpand;

  final DropDownMenuChangeCallback? onChange;

  final LayerLink? layerLink;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> with SingleTickerProviderStateMixin {
  OverlayEntry? _overlayEntry;
  List<DropDownMenuModel> get _filterList => widget.filterList;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Color _maskColor = Colors.black45;
  late final LayerLink layerLink;

  late DropDownMenuController _dropDownMenuController;

  late final DropDownMenuExpandIndex expandIndex;
  late final DropDownMenuSelectValues selectValues;

  bool _canPop = true;

  @override
  void initState() {
    super.initState();
    layerLink = widget.layerLink ?? LayerLink();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300), // 设置动画持续时间
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController); // 定义动画的值范围
    _animation.addStatusListener((status) {
      if (_animation.value == 0 && _animation.status == AnimationStatus.dismissed) {
        // 移除遮罩层
        _overlayEntry?.remove();
        _overlayEntry = null;
      }
    });
    final List<String> emptyList = [];
    final List<List<String>> selectedValues =
        _filterList.map((e) => e.defaultValue != null ? [e.defaultValue!] : emptyList).toList();
    expandIndex = DropDownMenuExpandIndex(expandedIndex: -1);
    selectValues = DropDownMenuSelectValues(selectedValues: selectedValues);
    _dropDownMenuController = widget.controller ?? DropDownMenuController();
    // 初始化控制器
    _dropDownMenuController.attach(expandIndex);
    // 根据索引变化，收缩
    expandIndex.addListener(() {
      setState(() {
        _canPop = expandIndex.index < 0;
      });
      if (expandIndex.index == -1) {
        closeMenu();
      }
    });
  }

  @override
  void deactivate() {
    _dropDownMenuController.closeMenu();
    super.deactivate();
  }

  @override
  void dispose() {
    closeMenuNoAnimation();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvoked: (_) {
        closeMenu();
      },
      child: Builder(builder: ((context) {
        final child = Row(
          children: List.generate(_filterList.length, (index) {
            return GestureDetector(
              onTap: () => handleTabClick(index),
              child: ListenableBuilder(
                listenable: expandIndex,
                builder: ((context, child) {
                  DropDownMenuModel item = _filterList[index];
                  final values = selectValues.values[index];
                  final hightLight = values.isNotEmpty && values.first != item.defaultValue;
                  // 找寻匹配的菜单选项
                  final findItemIndex =
                      values.isNotEmpty ? item.list.indexWhere((element) => element.value == values.first) : -1;
                  final menuLabel =
                      findItemIndex > -1 ? item.list[findItemIndex].name : (item.name ?? item.defaultValue ?? "null");
                  return Container(
                    padding: widget.padding ?? EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          menuLabel,
                          style:
                              TextStyle(fontSize: 14, color: hightLight ? Theme.of(context).colorScheme.primary : null),
                        ),
                        Icon(
                          expandIndex.index == index
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          size: 20,
                          color: hightLight ? Theme.of(context).colorScheme.primary : null,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            );
          }),
        );
        if (widget.layerLink != null) {
          return child;
        } else {
          return CompositedTransformTarget(
            link: layerLink,
            child: child,
          );
        }
      })),
    );
  }

  Widget _menuItem({required int itemIndex, required int menuIndex, required CategoryModel model}) {
    return GestureDetector(
      onTap: () => handleItemClick(itemIndex, menuIndex),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListenableBuilder(
          listenable: selectValues,
          builder: (context, child) {
            final itemValue = _filterList[menuIndex].list[itemIndex].value;
            final isSelected = selectValues.values[menuIndex].contains(itemValue);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 14,
                        color: isSelected ? Theme.of(context).colorScheme.primary : null,
                      ),
                ),
                if (isSelected) Icon(Icons.check, size: 16, color: Theme.of(context).colorScheme.primary),
              ],
            );
          },
        ),
      ),
    );
  }

  void handleTabClick(int menuIndex) {
    if (expandIndex.index == menuIndex) {
      closeMenu();
    } else {
      expandMenu(menuIndex);
    }
  }

  void handleItemClick(int itemIndex, int menuIndex) {
    final item = _filterList[menuIndex].list[itemIndex];
    final itemValue = item.value;
    final menuSelectedValues = selectValues.values.elementAt(menuIndex);
    final newSelectedValues = [...menuSelectedValues];

    // 单选逻辑
    newSelectedValues.clear();
    newSelectedValues.add(itemValue);
    selectValues.setMenuSelectedValues(
      menuIndex,
      newSelectedValues,
    );
    closeMenu();

    if (widget.onChange != null) widget.onChange!(menuIndex, item.value);
  }

  void changeOverlay({required int menuIndex, bool reset = false}) {
    // TAG: 更新OverlayEntry数据需要清空之后重新构建
    if (reset && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    RenderBox? renderBox = (context).findRenderObject() as RenderBox;
    double left = 0;
    _overlayEntry = buildOverlay(
      menuIndex,
      link: layerLink,
      offset: Offset(-left, renderBox.size.height),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry buildOverlay(menuIndex, {required link, required offset}) {
    return OverlayEntry(
      builder: (context) {
        return CompositedTransformFollower(
          link: link,
          offset: offset,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _animation,
                    child: GestureDetector(
                      onTap: closeMenu,
                      child: Container(color: _maskColor),
                    ),
                  );
                },
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SizeTransition(
                      sizeFactor: _animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -1), // 从顶部开始
                          end: Offset.zero,
                        ).animate(_animation),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: SizedBox(
                            child: ListView(
                              shrinkWrap: true,
                              children: _filterList[menuIndex].list.asMap().entries.map((e) {
                                int itemIndex = e.key;
                                CategoryModel item = e.value;
                                return _menuItem(model: item, itemIndex: itemIndex, menuIndex: menuIndex);
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 展开菜单
  void expandMenu(int menuIndex) {
    expandIndex.setExpandedIndex(menuIndex);
    showOverlay();
    changeOverlay(menuIndex: menuIndex, reset: true);
  }

  /// 收缩菜单
  void closeMenu() {
    expandIndex.closeExpanded();
    hideOverlay();
  }

  void closeMenuNoAnimation() {
    expandIndex.closeExpanded();
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
    _animationController.value = 0;
    _maskColor = Colors.transparent;
  }

  /// 显示遮罩
  void showOverlay() {
    // setState(() {
    _animationController.forward();
    _maskColor = Colors.black45;
    // });
  }

  /// 隐藏遮罩
  void hideOverlay() {
    // setState(() {
    _animationController.reverse();
    _maskColor = Colors.transparent;
    // });
  }
}
