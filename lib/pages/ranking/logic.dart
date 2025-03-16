import 'package:artvier/component/filter_dropdown/custom_dropdown.dart';
import 'package:artvier/pages/ranking/provider/ranking_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin RankingPageLogic {
  ScrollController get scrollController;
  CustomDropDownController get dropDownController;

  WidgetRef get ref;

  DateTime get datePickerValue;

  void handlePressedToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void handlePressedDatePicker() {
    dropDownController.toggle();
  }

  void handleRemoveDate() {
    handlePressedDateReset();
  }

  void handlePressedDateReset() {
    ref.read(rankingDateProvier.notifier).update((state) => null);
    dropDownController.close();
  }

  void handlePressedDateConfirm() {
    ref.read(rankingDateProvier.notifier).update((state) => datePickerValue);
    dropDownController.close();
  }
}
