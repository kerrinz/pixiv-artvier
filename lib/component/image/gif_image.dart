import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GifImageMeta {
  ui.Image image;

  /// 帧时间
  int delay;

  GifImageMeta({required this.image, required this.delay});
}

/// 动图
class GifImage extends StatefulWidget {
  final List<GifImageMeta> images; // 图片列表

  const GifImage({
    super.key,
    required this.images,
  });

  @override
  State<StatefulWidget> createState() => GifImageState();
}

class GifImageState extends State<GifImage> {
  int frameIndex = 1;
  late int maxIndex;

  @override
  void initState() {
    maxIndex = widget.images.length - 1;
    if (mounted) {
      play();
    }
    super.initState();
  }

  play() {
    GifImageMeta meta = widget.images[frameIndex];
    Future.delayed(Duration(milliseconds: meta.delay), () {
      if (mounted) {
        setState(() {
          if (frameIndex < maxIndex) {
            frameIndex++;
          } else {
            frameIndex = 0;
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
        image: widget.images[frameIndex].image,
      ),
    );
  }
}

class GifPainter extends CustomPainter {
  final ui.Image image;

  GifPainter({
    required this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 在画布上绘制当前帧
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, size.width.toDouble(), size.height.toDouble()),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
