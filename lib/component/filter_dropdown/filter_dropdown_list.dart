import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum DropDownMenuEventType {
  /// Click select item.
  selected,
}

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

  String get selectValue {
    if (list.isEmpty) return "";
    try {
      return list.firstWhere((element) => element.value != '' && element.check == true).value;
    } catch (e) {
      return "";
    }
  }

  DropDownMenuModel({
    this.name,
    this.id,
    this.defaultValue,
    required this.list,
  });
}

typedef DropDownMenuChangeCallback = void Function(DropDownMenuEventType, int tapIndex, String? value);

class DropDownMenuController {
  final ObserverList<DropDownMenuChangeCallback> _listeners = ObserverList<DropDownMenuChangeCallback>();
  int _listenerCounter = 0;

  void addListener(DropDownMenuChangeCallback listener) {
    didRegisterListener();
    _listeners.add(listener);
  }

  @protected
  void didRegisterListener() {
    assert(_listenerCounter >= 0);
    if (_listenerCounter == 0) {
      didStartListening();
    }
    _listenerCounter += 1;
  }

  void removeListener(DropDownMenuChangeCallback listener) {
    final bool removed = _listeners.remove(listener);
    if (removed) {
      didUnregisterListener();
    }
  }

  /// Removes all listeners added with [addListener].
  ///
  /// This method is typically called from the `dispose` method of the class
  /// using this mixin if the class also uses the [AnimationEagerListenerMixin].
  ///
  /// Calling this method will not trigger [didUnregisterListener].
  @protected
  void clearListeners() {
    _listeners.clear();
  }

  /// Calls all the listeners.
  ///
  /// If listeners are added or removed during this function, the modifications
  /// will not change which listeners are called during this iteration.
  @protected
  @pragma('vm:notify-debugger-on-exception')
  void notifyListeners(DropDownMenuEventType eventType, int tapIndex, String? value) {
    final List<DropDownMenuChangeCallback> localListeners = _listeners.toList(growable: false);
    for (final DropDownMenuChangeCallback listener in localListeners) {
      InformationCollector? collector;
      try {
        if (_listeners.contains(listener)) {
          listener(eventType, tapIndex, value);
        }
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
          library: 'animation library',
          context: ErrorDescription('while notifying listeners for $runtimeType'),
          informationCollector: collector,
        ));
      }
    }
  }

  @protected
  void didUnregisterListener() {
    assert(_listenerCounter >= 1);
    _listenerCounter -= 1;
    if (_listenerCounter == 0) {
      didStopListening();
    }
  }

  /// Called when the number of listeners changes from zero to one.
  @protected
  void didStartListening() {}

  /// Called when the number of listeners changes from one to zero.
  @protected
  void didStopListening() {}

  /// Whether there are any listeners.
  bool get isListening => _listenerCounter > 0;
}

///
class DropDownMenu extends StatefulWidget {
  const DropDownMenu({
    super.key,
    required this.filterList,
    this.layerLink,
    this.padding,
    this.controller,
  });

  final List<DropDownMenuModel> filterList;

  final EdgeInsets? padding;

  final DropDownMenuController? controller;

  final LayerLink? layerLink;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> with SingleTickerProviderStateMixin {
  int _curFilterIndex = -1;
  OverlayEntry? _overlayEntry;
  Map<int, BuildContext> itemContexts = {};
  late final List<DropDownMenuModel> _filterList;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Color _maskColor = Colors.black45;
  late final LayerLink layerLink;

  DropDownMenuController? get _dropDownMenuController => widget.controller;

  @override
  void initState() {
    super.initState();
    init();
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  init() async {
    _filterList = widget.filterList;
    for (var filter in widget.filterList) {
      if (filter.defaultValue != null) {
        for (var item in filter.list) {
          if (item.value == filter.defaultValue) {
            item.check = true;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) {
        hideOverlay();
      },
      child: Builder(builder: ((context) {
        final child = Row(
          children: List.generate(_filterList.length, (index) {
            return Builder(builder: ((context) {
              itemContexts[index] = context;
              DropDownMenuModel item = _filterList[index];
              bool isSelect = item.selectValue.isNotEmpty;
              final hightLight = item.selectValue != item.defaultValue && isSelect;
              return GestureDetector(
                onTap: () => handleTabClick(index),
                child: Padding(
                  padding: widget.padding ?? EdgeInsets.zero,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isSelect ? item.selectText : item.name ?? item.defaultValue ?? "",
                        style:
                            TextStyle(fontSize: 14, color: hightLight ? Theme.of(context).colorScheme.primary : null),
                      ),
                      Icon(
                        _curFilterIndex == index ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: hightLight ? Theme.of(context).colorScheme.primary : null,
                      ),
                    ],
                  ),
                ),
              );
            }));
          }),
        );
        if (widget.layerLink == null) {
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

  Widget _menuItem({required int index, required int rootIndex, required CategoryModel cate}) {
    final isSelected = _filterList[rootIndex].list[index].check;
    return GestureDetector(
      onTap: () => handleItemClick(index, rootIndex),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cate.name,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 14,
                    color: isSelected ? Theme.of(context).colorScheme.primary : null,
                  ),
            ),
            if (isSelected) Icon(Icons.check, size: 16, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }

  void handleTabClick(int index) {
    // 点击一样的就关闭
    if (_curFilterIndex == index) {
      hideOverlay();
      return;
    }
    setState(() {
      _curFilterIndex = index;
      _animationController.forward();
      _maskColor = Colors.black45;
    });
    changeOverlay(index: index, reset: true);
  }

  void handleItemClick(int index, int rootIndex) {
    for (CategoryModel item in _filterList[rootIndex].list) {
      item.check = false;
    }
    final item = _filterList[rootIndex].list[index];
    item.check = true;
    changeOverlay(index: rootIndex, reset: true);
    hideOverlay();

    _dropDownMenuController?.notifyListeners(DropDownMenuEventType.selected, rootIndex, item.value);
  }

  void changeOverlay({required int index, bool reset = false}) {
    // TAG: 更新OverlayEntry数据需要清空之后重新构建
    if (reset && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }

    RenderBox? renderBox = (context).findRenderObject() as RenderBox;
    // final Offset topLeft = renderBox.localToGlobal(Offset.zero);
    double left = 0;
    _overlayEntry = buildOverlay(
      index,
      link: widget.layerLink,
      offset: Offset(-left, renderBox.size.height),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry buildOverlay(index, {required link, required offset}) {
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
                      onTap: hideOverlay,
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
                              children: _filterList[index].list.asMap().entries.map((e) {
                                int itemIndex = e.key;
                                CategoryModel item = e.value;
                                return _menuItem(cate: item, index: itemIndex, rootIndex: index);
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

  void hideOverlay() {
    setState(() {
      _curFilterIndex = -1;
      _animationController.reverse();
      _maskColor = Colors.transparent;
    });
  }
}
