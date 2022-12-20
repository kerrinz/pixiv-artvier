import 'package:flutter/material.dart';

/// Artwork Page的子页面，更多相似作品
class SimilarWorksTabPage extends StatelessWidget {
  final String artworkId;

  const SimilarWorksTabPage({Key? key, required this.artworkId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        color: Colors.amber.withAlpha(5),
        child: Column(
          children: const [
            Text("1"),
            Text("2"),
          ],
        ),
      ),
    );
  }
}
/// Artwork Page的子页面，更多相似作品
class SimilarWorksTabPage2 extends StatelessWidget {
  final String artworkId;

  const SimilarWorksTabPage2({Key? key, required this.artworkId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 400,
        color: Colors.amber.withAlpha(5),
        child: Column(
          children: const [
            Text("1"),
            Text("2"),
          ],
        ),
      ),
    );
  }
}
