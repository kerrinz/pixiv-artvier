import 'package:flutter/material.dart';
import 'package:pixgem/api_app/api_base.dart';
import 'package:pixgem/api_app/api_user.dart';
import 'package:pixgem/common_provider/works_filter_provider.dart';
import 'package:pixgem/component/base_provider_widget.dart';
import 'package:pixgem/component/filter/flow_filter.dart';
import 'package:pixgem/component/illusts_grid_tabpage.dart';
import 'package:pixgem/component/novel_list/novel_list.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';

class WorksTabPage extends StatelessWidget {
  final WorksTypeProvider _worksTypeProvider = WorksTypeProvider();
  final String userId;
  final ScrollPhysics? physics;

  WorksTabPage({
    Key? key,
    required this.userId,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal :12, vertical: 8),
          child: Row(
            children: [
              TextFlowFilter(
                filterMode: FilterMode.single,
                selectedBackground: Theme.of(context).colorScheme.secondary,
                selectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
                unselectedTextStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
                textPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                textBorderRadius: const BorderRadius.all(Radius.circular(20)),
                spacing: 8,
                onTap: (bool isChanged, int tapIndex, Set<int> afterIndexes) {
                  if (isChanged) {
                    switch (tapIndex) {
                      case 0:
                        _worksTypeProvider.setCurrentWorksType(WorksType.illust);
                        break;
                      case 1:
                        _worksTypeProvider.setCurrentWorksType(WorksType.manga);
                        break;
                      case 2:
                        _worksTypeProvider.setCurrentWorksType(WorksType.novel);
                    }
                  }
                },
                texts: [
                  LocalizationIntl.of(context).illustrations,
                  LocalizationIntl.of(context).manga,
                  LocalizationIntl.of(context).novels
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ProviderWidget<WorksTypeProvider>(
            model: _worksTypeProvider,
            builder: (BuildContext context, WorksTypeProvider provider, Widget? child) {
              switch (provider.currentWorksType) {
                case WorksType.illust:
                case WorksType.manga:
                  // return IllustWaterfallGrid(
                  //   physics: physics,
                  //   artworkList: provider.list!,
                  //   onLazyLoad: () async {},
                  // );
                  return IllustGridTabPage(
                    onLazyLoad: (String nextUrl) async {
                      var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
                      return CommonIllustList.fromJson(result);
                    },
                    onRefresh: () async {
                      return await ApiUser().getUserIllusts(
                          userId: userId,
                          type: provider.currentWorksType == WorksType.manga
                              ? CONSTANTS.type_manga
                              : CONSTANTS.type_illusts);
                    },
                  );
                case WorksType.novel:
                  return const NovelList();
              }
            },
          ),
        ),
      ],
    );
  }

  Future refresh(WorksType worksType) async {
    await ApiUser().getUserIllusts(
      userId: userId,
      // type: provider.currentWorksType == WorksType.manga ? CONSTANTS.type_manga : CONSTANTS.type_illusts,
    );
  }
}
