import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheets {
  static Future<T?> showCustomBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    Color? background,
    Color barrierColor = Colors.black54,
    borderRadius = const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
    enableDrag = true, // 拖拽退出
    exitOnClickModal = true, // 点击遮罩层退出
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      elevation: 0,
      barrierColor: barrierColor, // 遮罩层颜色
      builder: (BuildContext context) {
        return Stack(
          children: [
            if (exitOnClickModal) GestureDetector(onTap: () => Navigator.of(context).pop()),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: background ?? Theme.of(context).colorScheme.surface,
                  borderRadius: borderRadius,
                ),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }

  // 列表选择菜单，返回选中的索引，无选择则返回-1
  static Future<int> showSelectItemsBottomSheet({
    required BuildContext context,
    required List<String> items,
    String? title,
    int selectedIndex = -1, // 选中哪一项
    barrierColor = Colors.black38,
    enableDrag = true,
    showCancel = false, // 是否显示取消按钮
    String? cancelText, // 取消按钮的文字
  }) async {
    int selected = -1;
    await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor, // 遮罩层颜色
      builder: (BuildContext context) {
        return Stack(
          children: [
            GestureDetector(onTap: () => Navigator.of(context).pop()),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                child: SafeArea(
                  bottom: true,
                  minimum: EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BottomSheetSlideBar(),
                        if (title != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(title, style: TextTheme.of(context).titleSmall),
                          ),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            children: [
                              for (var i = 0; i < items.length; i++)
                                InkWell(
                                  splashFactory: InkSparkle.splashFactory,
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  onTap: () {
                                    selected = i;
                                    Navigator.of(context).pop();
                                  },
                                  child: Padding(
                                    padding: EdgeInsetsGeometry.symmetric(vertical: 12, horizontal: 24),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(items[i]),
                                        ),
                                        Opacity(
                                          opacity: selectedIndex == i ? 1 : 0,
                                          child: Icon(Icons.check_rounded),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              if (showCancel)
                                Container(
                                  width: double.infinity,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                  padding: const EdgeInsets.only(top: 8),
                                  child: SafeArea(
                                    bottom: true,
                                    child: CupertinoButton(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.zero,
                                      child: Text(
                                        cancelText ?? LocalizationIntl.of(context).promptCancel,
                                        style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    return selected;
  }
}
