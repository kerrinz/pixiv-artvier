import 'package:flutter/material.dart';
import 'package:pixgem/common_provider/global_provider.dart';
import 'package:pixgem/component/bottom_sheet/slide_bar.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class ThemeSettingsBottomSheetContent extends StatelessWidget {
  const ThemeSettingsBottomSheetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BottomSheetSlideBar(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24),
          child: Selector(selector: (BuildContext context, GlobalProvider provider) {
            return provider.themeMode;
          }, builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
            return _buildBrightnessCard(context, themeMode);
          }),
        ),
      ],
    );
  }

  // 切换亮度主题，例如暗黑模式
  Widget _buildBrightnessCard(BuildContext context, ThemeMode themeMode) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        // side: BorderSide(width: 1, color: Colors.white),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (themeMode != ThemeMode.light) GlobalStore.globalProvider.setThemeMode(ThemeMode.light, true);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(child: Text("亮色模式", style: TextStyle(fontSize: 16))),
                  themeMode == ThemeMode.light
                      ? Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.secondary)
                      : Container(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (themeMode != ThemeMode.dark) GlobalStore.globalProvider.setThemeMode(ThemeMode.dark, true);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(child: Text("暗黑模式", style: TextStyle(fontSize: 16))),
                  themeMode == ThemeMode.dark
                      ? Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.secondary)
                      : Container(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (themeMode != ThemeMode.system) GlobalStore.globalProvider.setThemeMode(ThemeMode.system, true);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(child: Text("自动跟随系统", style: TextStyle(fontSize: 16))),
                  themeMode == ThemeMode.system
                      ? Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.secondary)
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
