import 'package:flutter/material.dart';

mixin ArtworksRankingPageLogic {
  ScrollController get scrollController;

  void handlePressedToTop() {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}