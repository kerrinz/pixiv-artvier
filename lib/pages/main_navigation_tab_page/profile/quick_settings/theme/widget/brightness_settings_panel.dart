import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/perference/perference_container.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/global/provider/themes_provider.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/theme/widget/brightness_select_widget.dart';

class BrightnessSettingsPanel extends ConsumerWidget with _Logic {
  const BrightnessSettingsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var l10n = LocalizationIntl.of(context);
    return PerferenceContainer(
      groups: [
        Consumer(builder: (_, ref, __) {
          ref.watch(globalThemeModeProvider); // 跟随它变化进行刷新

          // 当前App是否为浅色
          bool isLight = Theme.of(context).brightness == Brightness.light;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 浅色选项
              BrightnessSelectWidget(
                brightness: Brightness.light,
                isSelected: isLight,
                onTap: () {
                  HapticFeedback.lightImpact();
                  ref.read(globalThemeModeProvider.notifier).switchThemeMode(ThemeMode.light);
                },
              ),
              // 深色选项
              BrightnessSelectWidget(
                brightness: Brightness.dark,
                isSelected: !isLight,
                onTap: () {
                  HapticFeedback.lightImpact();
                  ref.read(globalThemeModeProvider.notifier).switchThemeMode(ThemeMode.dark);
                },
              ),
            ],
          );
        }),
        // 跟随系统
        Consumer(builder: (_, ref, __) {
          var themeMode = ref.watch(globalThemeModeProvider);
          return PerferenceGroup(items: [
            PerferenceItem(
              text: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.autoSwitchFollowingSystem, style: const TextStyle(fontSize: 16)),
                  Text(l10n.autoSwitchFollowingSystemDesc,
                      style: TextStyle(fontSize: 12, color: Theme.of(ref.context).textTheme.bodySmall?.color)),
                ],
              ),
              // 跟随系统的开关
              value: CupertinoSwitch(
                value: themeMode == ThemeMode.system,
                onChanged: (value) {
                  if (Theme.of(context).platform == TargetPlatform.android) {
                    HapticFeedback.lightImpact();
                  }
                  handleSwitchSystem(ref, value);
                },
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
          ]);
        }),
      ],
    );
  }
}

mixin _Logic {
  /// 开关：浅色深色模式自动跟随系统
  handleSwitchSystem(WidgetRef ref, bool value) {
    ThemeMode themeMode;
    if (value) {
      // 自动
      themeMode = ThemeMode.system;
    } else {
      // 使用系统当前的Brightness作为ThemeMode
      themeMode = Theme.of(ref.context).brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
    }
    ref.read(globalThemeModeProvider.notifier).switchThemeMode(themeMode);
  }
}
