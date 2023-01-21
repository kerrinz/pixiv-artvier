import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/component/bottom_sheet/slide_bar.dart';
import 'package:pixgem/global/provider/shared_preferences_provider.dart';
import 'package:pixgem/global/provider/themes_provider.dart';
import 'package:pixgem/storage/theme_storage.dart';

class ThemeSettingsBottomSheetContent extends ConsumerWidget {
  const ThemeSettingsBottomSheetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const BottomSheetSlideBar(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 24),
          child: Consumer(builder: (_, ref, __) {
            var themeMode = ref.watch(globalThemeModeProvider);
            return _buildBrightnessCard(ref, themeMode);
          }),
        ),
      ],
    );
  }

  // 切换亮度主题，例如暗黑模式
  Widget _buildBrightnessCard(WidgetRef ref, ThemeMode themeMode) {
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
              if (themeMode != ThemeMode.light) {
                ThemeStorage(ref.read(globalSharedPreferencesProvider)).setThemeMode(ThemeMode.light);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(child: Text("亮色模式", style: TextStyle(fontSize: 16))),
                  themeMode == ThemeMode.light
                      ? Icon(Icons.done_rounded, color: Theme.of(ref.context).colorScheme.secondary)
                      : Container(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (themeMode != ThemeMode.light) {
                ThemeStorage(ref.read(globalSharedPreferencesProvider)).setThemeMode(ThemeMode.dark);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(child: Text("暗黑模式", style: TextStyle(fontSize: 16))),
                  themeMode == ThemeMode.dark
                      ? Icon(Icons.done_rounded, color: Theme.of(ref.context).colorScheme.secondary)
                      : Container(),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (themeMode != ThemeMode.light) {
                ThemeStorage(ref.read(globalSharedPreferencesProvider)).setThemeMode(ThemeMode.system);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Expanded(child: Text("自动跟随系统", style: TextStyle(fontSize: 16))),
                  themeMode == ThemeMode.system
                      ? Icon(Icons.done_rounded, color: Theme.of(ref.context).colorScheme.secondary)
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
