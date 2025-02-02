import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/main_navigation_tab_page/profile/quick_settings/theme/widget/brightness_settings_panel.dart';

class ThemeSettingsBottomSheet extends ConsumerWidget {
  const ThemeSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var l10n = LocalizationIntl.of(context);
    return SafeArea(
      child: Column(
        children: [
          const BottomSheetSlideBar(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(l10n.dartModeSettingsTitle, style: Theme.of(context).textTheme.titleMedium),
          ),
          const BrightnessSettingsPanel(),
        ],
      ),
    );
  }
}
