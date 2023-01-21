import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/business_component/advanced_collecting_bottom_sheet/advanced_collecting_bottom_sheet.dart';
import 'package:pixgem/business_component/advanced_collecting_bottom_sheet/model/advanced_collecting_data.dart';
import 'package:pixgem/business_component/advanced_collecting_bottom_sheet/provider/advanced_collecting_provider.dart';
import 'package:pixgem/config/enums.dart';
import 'package:pixgem/global/logger.dart';
import 'package:pixgem/l10n/localization_intl.dart';
import 'package:pixgem/model_response/common/collection_detail.dart';
import 'package:pixgem/global/provider/collection_state_provider.dart';

typedef TheProvider = AutoDisposeStateNotifierProvider<CollectionTagsNotifier, AdvancedCollectingDataModel>;

mixin AdvancedCollectingBottomSheetLogic {
  late final WidgetRef ref;

  late String worksId;

  late WorksType worksType;

  late bool isCollected;

  late TextEditingController addTagTextController;

  /// 作品收藏详情的Provider
  TheProvider get detailProvider => worksType == WorksType.novel
      ? advancedCollectingNovelDetailProvider(worksId)
      : advancedCollectingArtworkDetailProvider(worksId);

  late final collectingProvider = StateNotifierProvider<CollectNotifier, CollectState>(((ref) {
    return CollectNotifier(isCollected ? CollectState.collected : CollectState.notCollect,
        ref: ref, worksId: worksId, worksType: worksType);
  }));

  /// 收藏事件
  void handlePressedCollecting() {
    try {
      var args = ref.read(advancedCollectingArtworkDetailProvider(worksId));
      ref.read(collectingProvider.notifier).collect(args: args);
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
    var data = ref.read(detailProvider);
    int countSelected =
        data.tags.fold<int>(0, (previousValue, element) => previousValue + (element.isRegistered ?? false ? 1 : 0));
    if (countSelected <= AdvancedCollectingBottomSheet.maxSelectedTags) {
      bool isNotExist = data.tags.every(((element) => element.name != inputText));
      if (isNotExist) {
        ref.read(detailProvider.notifier).addTag(inputText, true);
        addTagTextController.text = "";
      } else {
        Fluttertoast.showToast(msg: LocalizationIntl.of(ref.context).tagAlreadyExists);
      }
    }
  }

  /// 选择标签
  void handleTapTagsItem(int index, List<WorksCollectTag> tags) {
    WorksCollectTag tag = tags[index];
    bool isSelected = tag.isRegistered ?? false;
    ref.read(detailProvider.notifier).updateTag(index, tag..isRegistered = !isSelected);
  }

  /// 切换隐私限制
  void handleTapRestrictSelection(int selectionIndex) {
    var allSelection = [Restrict.public, Restrict.private];
    ref.read(detailProvider.notifier).updateRestrict(allSelection[selectionIndex]);
  }
}
