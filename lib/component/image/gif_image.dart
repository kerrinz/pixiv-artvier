import 'dart:ui';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GifImage extends StatefulWidget {
  final List<ui.Image> images; // 图片帧列表
  final int delay; // 帧时间（milliseconds）
  // final double fps; // 帧率

  const GifImage({
    super.key,
    required this.images,
    required this.delay,
  });

  @override
  State<StatefulWidget> createState() => GifImageState();
}

class GifImageState extends State<GifImage> {
  int currentFrame = 1;
  late int maxFrame;

  @override
  void initState() {
    maxFrame = widget.images.length;
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        play();
      }
    });
    super.initState();
  }

  play() {
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() {
          if (currentFrame < maxFrame) {
            currentFrame++;
          } else {
            currentFrame = 1;
          }
        });
        play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.sizeOf(context),
      painter: GifPainter(
        images: widget.images,
        currentFrame: currentFrame,
      ),
    );
  }
}

class GifPainter extends CustomPainter {
  final List<ui.Image> images; // 图片帧列表
  final int currentFrame; // 当前帧的索引

  GifPainter({
    required this.images,
    required this.currentFrame,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 在画布上绘制当前帧
    if (images.isNotEmpty) {
      final image = images[currentFrame - 1];
      canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, size.width.toDouble(), size.height.toDouble()),
        Paint(),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
