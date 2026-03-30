import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/pages/settings/resource_load/provider.dart';
import 'package:flutter/material.dart';

/// 资源加载相关设置
class ResourceLoadSettingsPage extends BaseStatefulPage {
  const ResourceLoadSettingsPage({super.key});

  @override
  ResourceLoadSettingsPageState createState() => ResourceLoadSettingsPageState();
}

class ResourceLoadSettingsPageState extends BasePageState {
  final listPreviewQualityArray = [
    ListPreviewQuality.medium,
    ListPreviewQuality.large,
  ];
  final illustDetailQualityArray = [
    DetailsPageQuality.medium,
    DetailsPageQuality.original,
    DetailsPageQuality.large,
  ];
  final mangaDetailQualityArray = [
    DetailsPageQuality.medium,
    DetailsPageQuality.original,
    DetailsPageQuality.large,
  ];

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
            minHeight: MediaQuery.sizeOf(context).height -
                MediaQuery.paddingOf(context).top -
                MediaQuery.paddingOf(context).bottom,
          ),
          child: Builder(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 列表预览画质
                Builder(builder: (context) {
                  final quality = ref.watch(resourceLoadSettingsProvider.select((value) => value.listPreviewQuality));
                  return PerferenceItem(
                    onTap: () async {
                      final selected = await BottomSheets.showSelectItemsBottomSheet(
                        context: context,
                        title: l10n.listPreviewQuality,
                        items: [
                          l10n.mediumQuality,
                          l10n.largeQuality,
                        ],
                        selectedIndex: listPreviewQualityArray.indexWhere((el) => el == quality),
                      );
                      ref.read(resourceLoadSettingsProvider.notifier).switchListPreviewQuality(
                          selected == 0 ? ListPreviewQuality.medium : ListPreviewQuality.large);
                    },
                    text: Text(
                      l10n.listPreviewQuality,
                      style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                    ),
                    value: Text(listPreviewQualityText(quality, l10n)),
                  );
                }),
                // 插画详情页画质
                Builder(builder: (context) {
                  final quality = ref.watch(resourceLoadSettingsProvider.select((value) => value.illustDetailsQuality));
                  return PerferenceItem(
                    onTap: () async {
                      final selected = await BottomSheets.showSelectItemsBottomSheet(
                          context: context,
                          title: l10n.illustDetailQuality,
                          selectedIndex: illustDetailQualityArray.indexWhere((el) => el == quality),
                          items: [
                            l10n.mediumQuality,
                            l10n.largeQuality,
                            l10n.originQuality,
                          ]);
                      if (selected >= 0 && selected < 3) {
                        ref.read(resourceLoadSettingsProvider.notifier).switchIllustDetailsQuality([
                              DetailsPageQuality.medium,
                              DetailsPageQuality.original,
                              DetailsPageQuality.large
                            ][selected]);
                      }
                    },
                    text: Text(
                      l10n.illustDetailQuality,
                      style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                    ),
                    value: Text(detailsQuality(quality, l10n)),
                  );
                }),
                // 漫画详情页画质
                Builder(builder: (context) {
                  final quality = ref.watch(resourceLoadSettingsProvider.select((value) => value.mangaDetailsQuality));
                  return PerferenceItem(
                    onTap: () async {
                      final selected = await BottomSheets.showSelectItemsBottomSheet(
                          context: context,
                          title: l10n.mangaDetailQuality,
                          selectedIndex: mangaDetailQualityArray.indexWhere((el) => el == quality),
                          items: [
                            l10n.mediumQuality,
                            l10n.largeQuality,
                            l10n.originQuality,
                          ]);
                      if (selected >= 0 && selected < 3) {
                        ref.read(resourceLoadSettingsProvider.notifier).switchMangaDetailsQuality(
                              mangaDetailQualityArray[selected],
                            );
                      }
                    },
                    text: Text(
                      l10n.mangaDetailQuality,
                      style: textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                    ),
                    value: Text(detailsQuality(quality, l10n)),
                  );
                }),
              ],
            );
          }),
        ),
      ),
    );
  }

  String listPreviewQualityText(ListPreviewQuality quality, LocalizationIntl l10n) {
    final map = {
      ListPreviewQuality.medium: l10n.mediumQuality,
      ListPreviewQuality.large: l10n.largeQuality,
    };
    return map[quality] ?? l10n.mediumQuality;
  }

  String detailsQuality(DetailsPageQuality quality, LocalizationIntl l10n) {
    final map = {
      DetailsPageQuality.medium: l10n.mediumQuality,
      DetailsPageQuality.large: l10n.largeQuality,
      DetailsPageQuality.original: l10n.originQuality,
    };
    return map[quality] ?? l10n.largeQuality;
  }
}

class QualitySelector {}
