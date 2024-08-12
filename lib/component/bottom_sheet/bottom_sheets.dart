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

  // 列表选择菜单
  static showSelectItemsBottomSheet({
    required BuildContext context,
    required List<Widget> items,
    barrierColor = Colors.black38,
    enableDrag = true,
    showCancel = true, // 是否显示取消按钮
    String cancelText = "取消", // 取消按钮的文字
  }) {
    showModalBottomSheet<int>(
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
                  color: Theme.of(context).dialogBackgroundColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                ),
                child: Column(
                  children: [
                    ...items,
                    Container(
                      width: double.infinity,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      padding: const EdgeInsets.only(top: 8),
                      child: CupertinoButton(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.zero,
                        child: Text(
                          cancelText,
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
