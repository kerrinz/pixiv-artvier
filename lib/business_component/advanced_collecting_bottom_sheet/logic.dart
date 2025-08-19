import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/advanced_collecting_bottom_sheet.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/provider/collecting_provider.dart';
import 'package:artvier/business_component/advanced_collecting_bottom_sheet/provider/states_provider.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/common/collection_detail.dart';

mixin AdvancedCollectingBottomSheetLogic {
  WidgetRef get ref;

  late String worksId;

  late WorksType worksType;

  bool get isCollected;

  late TextEditingController addTagTextController;

  /// 高级收藏展示的内容状态
  late final statesProvider =
      AsyncNotifierProvider.autoDispose<AdvancedCollectingStatesNotifier, AdvancedCollectingDataModel>(
          () => AdvancedCollectingStatesNotifier(worksId: worksId, worksType: worksType));

  /// 收藏事件
  void handlePressedCollecting() {
    HapticFeedback.lightImpact();
    try {
      var collectingProvider = worksType == WorksType.novel
          ? novelAdvancedCollectingProvider(worksId)
          : artworkAdvancedCollectingProvider(worksId);
      var states = ref.read(statesProvider).value!;
      // 标签（名称）列表
      List<String> tagNameList = [
        for (WorksCollectTag item in states.tags)
          if ((item.isRegistered ?? false) && item.name != null) item.name!,
      ];
      ref.read(collectingProvider.notifier).collect(
            oldCollectState: ref.read(collectingProvider)!,
            restrict: states.restrict,
            tagNameList: tagNameList,
          );
      Navigator.pop(ref.context);
    } catch (e) {
      logger.e(e);
    }
  }

  /// 添加标签
  void handleSubmittedAddTag() {
    String inputText = addTagTextController.text;
    if (inputText.isEmpty) {
      return;
    }
    var data = ref.read(statesProvider).value!;
    // 统计选择数量
    int countSelected =
        data.tags.fold<int>(0, (previousValue, element) => previousValue + (element.isRegistered ?? false ? 1 : 0));
    // 不能超过最大限制
    if (countSelected < AdvancedCollectingBottomSheet.maxSelectedTags) {
      bool isNotExist = data.tags.every(((element) => element.name != inputText));
      // 不允许重复
      if (isNotExist) {
        ref.read(statesProvider.notifier).addTag(inputText, true);
        addTagTextController.text = "";
      } else {
        Fluttertoast.showToast(msg: LocalizationIntl.of(ref.context).tagAlreadyExists);
      }
    } else {
      Fluttertoast.showToast(msg: LocalizationIntl.of(ref.context).tagsReachedMaximun);
    }
  }

  /// 点击标签项，选择标签
  void handleTapTagsItem(int index, List<WorksCollectTag> tags) {
    ref.read(statesProvider.notifier).updateTag(index, newIsSelected: !(tags[index].isRegistered ?? false));
  }

  /// 切换隐私限制
  void handleTapRestrictSelection(int selectionIndex) {
    ref.read(statesProvider.notifier).updateRestrict(
          ref.read(statesProvider).value!.restrict == Restrict.public ? Restrict.private : Restrict.public,
        );
  }
}
