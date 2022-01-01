import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDialog {
  static void showSelectItemListDialog(BuildContext context, Column columnItems) {
    showGeneralDialog<int>(
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.black26, // 遮罩层
          body: Stack(
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
                      columnItems,
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: CupertinoButton(
                      //     child: const Text("确定"),
                      //     onPressed: () {},
                      //   ),
                      // ),
                      // 取消按钮
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        padding: const EdgeInsets.only(top: 8),
                        child: CupertinoButton(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.zero,
                          child: Text(
                            "取消",
                            style: TextStyle(color: Colors.grey),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
