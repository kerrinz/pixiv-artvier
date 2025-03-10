import 'package:flutter/material.dart';

mixin RankingPageLogic {
  ScrollController get scrollController;

  void handlePressedToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}