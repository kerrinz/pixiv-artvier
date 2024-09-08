import 'package:artvier/business_component/ugoira_image/model.dart';
import 'package:artvier/business_component/ugoira_image/provider.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/image/gif_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UgoiraImage extends ConsumerWidget {
  final Size size;
  final String illustId;
  const UgoiraImage({
    super.key,
    required this.size,
    required this.illustId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          // 动图
          Consumer(builder: (context, ref, child) {
            var loadingState = ref.watch(ugoiraIllustProvider(illustId).select((value) => value.loadingState));
            var images = ref.watch(ugoiraIllustProvider(illustId).select((value) => value.images));
            if (loadingState == UgoiraImageLoadingState.success) {
              return GifImage(images: images!);
            } else {
              return const SizedBox();
            }
          }),
          // 加载按钮
          Positioned(
            right: 12,
            bottom: 40,
            child: Consumer(builder: (context, ref, child) {
              var state = ref.watch(ugoiraIllustProvider(illustId));
              switch (state.loadingState) {
                case UgoiraImageLoadingState.paused:
                  return BlurButton(
                    onPressed: () {
                      ref.read(ugoiraIllustProvider(illustId).notifier).start();
                    },
                    width: 46,
                    height: 46,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    background: Colors.black45,
                    child: const Icon(Icons.play_arrow_rounded, size: 32),
                  );
                case UgoiraImageLoadingState.downloading:
                case UgoiraImageLoadingState.compositing:
                case UgoiraImageLoadingState.unziping:
                  return BlurButton(
                    width: 46,
                    height: 46,
                    pressedOpacity: 1,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    background: Colors.black45,
                    child: Center(child: Text('${(state.progress * 100).round()}%')),
                  );
                case UgoiraImageLoadingState.failed:
                  return BlurButton(
                    onPressed: () {
                      ref.read(ugoiraIllustProvider(illustId).notifier).start();
                    },
                    width: 46,
                    height: 46,
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    background: Colors.black45,
                    child: const Icon(Icons.error_outline_rounded, size: 32),
                  );
                case UgoiraImageLoadingState.success:
                  return const SizedBox(width: 0, height: 0);
              }
            }),
          ),
        ],
      ),
    );
  }
}
