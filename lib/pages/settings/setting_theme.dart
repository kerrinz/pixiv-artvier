import 'package:flutter/material.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class SettingThemePage extends StatefulWidget {
  const SettingThemePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingThemeState();
  }
}

class _SettingThemeState extends State<SettingThemePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("主题设置"),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          // 这样解决了内容不足以支撑全屏时，滑动回弹不会回到原位的问题
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Selector(selector: (BuildContext context, GlobalProvider provider) {
                return provider.themeMode;
              }, builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
                return _buildBrightnessCard(themeMode);
              }),
            ],
          ),
        ),
      ),
    );
  }

  // 切换亮度主题，例如暗黑模式
  Widget _buildBrightnessCard(ThemeMode themeMode) {
    return Card(
      elevation: 1.5,
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
