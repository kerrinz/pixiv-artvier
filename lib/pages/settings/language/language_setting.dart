import 'package:artvier/base/base_page.dart';
import 'package:artvier/global/provider/language_provider.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:flutter/material.dart';
import 'package:artvier/component/perference/perference_single_choise_panel.dart';

class LanguageSettingPage extends BaseStatefulPage {
  const LanguageSettingPage({super.key});

  @override
  LanguageSettingPageState createState() => LanguageSettingPageState();
}

class LanguageSettingPageState<LanguageSettingPage> extends BasePageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.languageSettings),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          padding: const EdgeInsets.all(8),
          // 这样解决了内容不足以支撑全屏时，滑动回弹不会回到原位的问题
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (context) {
                final globalLocale = ref.watch(globalLanguageProvider);
                final indexOfLanguageLocale = findIndexOfLanguageLocale(globalLocale);
                return PerferenceSingleChoisePanel(
                  title: l10n.selectLanguage,
                  selectedindex: globalLocale == null ? 0 : (indexOfLanguageLocale + 1),
                  onSelect: (index) {
                    if (index == 0) {
                      ref.read(globalLanguageProvider.notifier).setLocale(null);
                    } else {
                      ref.read(globalLanguageProvider.notifier).setLocale(LocalizationIntl.supportedLocales[index - 1]);
                    }
                  },
                  widgets: <Widget>[
                    Text(
                      l10n.languageFollowSystem,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Text(
                      l10n.languageZhCn,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Text(
                      l10n.languageEnUS,
                      style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  int findIndexOfLanguageLocale(Locale? globalLanguageLocale) {
    if (globalLanguageLocale == null) return 0;
    final findIndex = LocalizationIntl.supportedLocales.indexWhere((element) =>
        element.languageCode == globalLanguageLocale.languageCode &&
        element.countryCode == globalLanguageLocale.countryCode);
    if (findIndex < 0) return -1;
    return findIndex;
  }
}
