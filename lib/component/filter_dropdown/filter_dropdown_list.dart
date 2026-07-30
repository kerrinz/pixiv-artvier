import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:flutter/material.dart';

typedef DropDownMenuListenerCallback = void Function();
typedef DropDownMenuChangeCallback = void Function(int index, String? value);
typedef DropDownMenuExpandCallback = void Function(int index, bool expanded);
typedef CategoryCustomWidgetBuilder = Widget Function(BuildContext context, bool checked);
/// 点击后执行动作，不改变选中态。用于「指定日期」这类需要二次弹窗的选项。
typedef CategoryActionCallback = void Function(BuildContext context, int menuIndex);

class CategoryModel {
  String value;
  String name;
  bool check;
  CategoryCustomWidgetBuilder? customWidgetBuilder;
  CategoryActionCallback? onAction;

  CategoryModel({
    required this.value,
    required this.name,
    required this.check,
    this.customWidgetBuilder,
    this.onAction,
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
  // 自定义菜单底部内容（不参与菜单选择）
  Widget? bottomWidget;

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
    this.bottomWidget,
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

  void setExpandedIndex(int index) {
    _expandedIndex = index;
    notifyListeners();
  }

  @override
  notifyListeners() {
    super.notifyListeners();
  }

  /// 关闭已展开的菜单
  void closeExpanded() {
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

  void setAllSelectedValues(List<List<String>> selectedValues) {
    _selectedValues = selectedValues;
    notifyListeners();
  }

  void setMenuSelectedValues(int menuIndex, List<String> selectedValueList) {
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
  _DropDownMenuOverlayHost? _overlayHost;

  bool isExpanded() {
    return _indexList.indexWhere((element) => element.index > -1) > -1;
  }

  void closeMenu() {
    for (var status in _indexList) {
      status.closeExpanded();
    }
  }

  /// 打开子级弹窗时暂时让遮罩层不拦截点击，下拉菜单保持可见
  Future<T?> showAboveMenu<T>({
    required Widget child,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = true,
    Color? background,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
  }) {
    if (_overlayHost != null) {
      return _overlayHost!.showAboveMenu(
        child: child,
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        background: background,
        borderRadius: borderRadius,
      );
    }
    return Future<T?>.value(null);
  }

  /// 程序化选中某菜单项（例如指定日期确认后高亮）
  void selectMenuValue(int menuIndex, String value) {
    _overlayHost?.selectMenuValue(menuIndex, value);
  }

  void attach(DropDownMenuExpandIndex status) {
    assert(!_indexList.contains(status));
    _indexList.add(status);
  }

  void detach(DropDownMenuExpandIndex status) {
    assert(_indexList.contains(status));
    _indexList.remove(status);
  }

  void _attachOverlayHost(_DropDownMenuOverlayHost host) {
    _overlayHost = host;
  }

  void _detachOverlayHost(_DropDownMenuOverlayHost host) {
    if (_overlayHost == host) {
      _overlayHost = null;
    }
  }
}

abstract class _DropDownMenuOverlayHost {
  Future<T?> showAboveMenu<T>({
    required Widget child,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = true,
    Color? background,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
  });

  void selectMenuValue(int menuIndex, String value);
}

/// 供下拉菜单内自定义 Widget 获取 [DropDownMenuController]
class DropDownMenuScope extends InheritedWidget {
  const DropDownMenuScope({
    super.key,
    required this.controller,
    required this.anchorContext,
    required super.child,
  });

  final DropDownMenuController controller;
  final BuildContext anchorContext;

  static DropDownMenuScope? maybeOf(BuildContext context) {
    // 在手势回调等非 build 场景使用，避免 dependOnInheritedWidget 断言
    return context.getInheritedWidgetOfExactType<DropDownMenuScope>();
  }

  Future<T?> showAboveMenu<T>({
    required Widget child,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = true,
    Color? background,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
  }) {
    return controller.showAboveMenu(
      child: child,
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      background: background,
      borderRadius: borderRadius,
    );
  }

  @override
  bool updateShouldNotify(DropDownMenuScope oldWidget) {
    return controller != oldWidget.controller || anchorContext != oldWidget.anchorContext;
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

class _DropDownMenuState extends State<DropDownMenu>
    with SingleTickerProviderStateMixin
    implements _DropDownMenuOverlayHost {
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
  OverlayEntry? _aboveOverlayEntry;
  VoidCallback? _dismissAboveOverlay;

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
        _removeAboveOverlay();
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
    _dropDownMenuController._attachOverlayHost(this);
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
    _dropDownMenuController._detachOverlayHost(this);
    closeMenuNoAnimation();
    _animationController.dispose();
    super.dispose();
  }

  void _removeAboveOverlay() {
    final dismiss = _dismissAboveOverlay;
    if (dismiss != null) {
      dismiss();
      return;
    }
    _aboveOverlayEntry?.remove();
    _aboveOverlayEntry = null;
  }

  @override
  Future<T?> showAboveMenu<T>({
    required Widget child,
    Color barrierColor = Colors.black54,
    bool barrierDismissible = true,
    Color? background,
    BorderRadiusGeometry borderRadius =
        const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
  }) async {
    // ModalRoute 插不进手动 OverlayEntry 之上，因此弹层也用 OverlayEntry。
    final menuEntry = _overlayEntry;
    if (menuEntry == null || !menuEntry.mounted) {
      return null;
    }

    _removeAboveOverlay();

    try {
      return await BottomSheets.showCustomBottomSheetOverlay<T>(
        overlayState: Overlay.of(context),
        insertAbove: menuEntry,
        child: child,
        barrierColor: barrierColor,
        exitOnClickModal: barrierDismissible,
        background: background,
        borderRadius: borderRadius,
        enableDrag: true,
        onAttached: (entry, close) {
          _aboveOverlayEntry = entry;
          _dismissAboveOverlay = close;
        },
      );
    } finally {
      _dismissAboveOverlay = null;
      _aboveOverlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop,
      onPopInvokedWithResult: (didPop, __) {
        if (didPop) return;
        // 先关上层日期弹窗，再关下拉菜单
        if (_aboveOverlayEntry != null) {
          _removeAboveOverlay();
          return;
        }
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
    return ListenableBuilder(
      listenable: selectValues,
      builder: (context, child) {
        final itemValue = _filterList[menuIndex].list[itemIndex].value;
        final isSelected = selectValues.values[menuIndex].contains(itemValue);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => handleItemClick(itemIndex, menuIndex),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        model.name,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontSize: 14,
                              color: isSelected ? Theme.of(context).colorScheme.primary : null,
                            ),
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check, size: 16, color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ),
            ),
            if (model.customWidgetBuilder != null && isSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: model.customWidgetBuilder!(context, isSelected),
              ),
          ],
        );
      },
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

    // 动作型选项：不改变选中态，关闭菜单后执行回调
    if (item.onAction != null) {
      final action = item.onAction!;
      final menuContext = context;
      closeMenu();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (menuContext.mounted) {
          action(menuContext, menuIndex);
        }
      });
      return;
    }

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

    if (item.customWidgetBuilder != null) {
      // 自定义选项展开后不关闭菜单，等待用户在自定义 Widget 内确认
      changeOverlay(menuIndex: menuIndex, reset: true);
      return;
    }

    closeMenu();
    if (widget.onChange != null) widget.onChange!(menuIndex, item.value);
  }

  @override
  void selectMenuValue(int menuIndex, String value) {
    if (menuIndex < 0 || menuIndex >= selectValues.values.length) return;
    selectValues.setMenuSelectedValues(menuIndex, [value]);
    _overlayEntry?.markNeedsBuild();
    if (mounted) setState(() {});
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

    final overlay = Overlay.of(context);
    final above = _aboveOverlayEntry;
    // 若已有上层弹层，菜单必须插回其下方，避免盖住日期弹窗
    if (above != null && above.mounted) {
      overlay.insert(_overlayEntry!, below: above);
    } else {
      overlay.insert(_overlayEntry!);
    }
  }

  OverlayEntry buildOverlay(menuIndex, {required link, required offset}) {
    final filterMenu = _filterList[menuIndex];
    return OverlayEntry(
      builder: (context) {
        return DropDownMenuScope(
          controller: _dropDownMenuController,
          anchorContext: this.context,
          child: CompositedTransformFollower(
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
                        child: Material(
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
                                children: [
                                  ...filterMenu.list.asMap().entries.map((e) {
                                    int itemIndex = e.key;
                                    CategoryModel item = e.value;
                                    return _menuItem(model: item, itemIndex: itemIndex, menuIndex: menuIndex);
                                  }),
                                  if (filterMenu.bottomWidget != null) _filterList[menuIndex].bottomWidget!,
                                ],
                              ),
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
    _removeAboveOverlay();
    expandIndex.closeExpanded();
    hideOverlay();
  }

  void closeMenuNoAnimation() {
    expandIndex.closeExpanded();
    _dismissAboveOverlay = null;
    _aboveOverlayEntry?.remove();
    _aboveOverlayEntry = null;
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
