import 'package:flutter/material.dart';

mixin ArtworksRankingPageLogic {
  late final ScrollController scrollController;

  void handlePressedToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}