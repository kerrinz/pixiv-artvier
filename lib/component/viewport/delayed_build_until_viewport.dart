import 'package:flutter/widgets.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// 延迟构建组件，直到进入视口
class DelayedBuildUntilViewportWidget extends StatefulWidget {
  const DelayedBuildUntilViewportWidget({
    super.key,
    required this.placeholderWidget,
    required this.child,
  });

  /// 从未进入过视口，占位渲染的组件，例如骨架屏、加载组件等
  final Widget placeholderWidget;

  /// 进入视口
  final Widget child;

  @override
  State<StatefulWidget> createState() => _DelayedBuildUntilViewportState();
}

/// 延迟构建组件，直到进入视口
///
/// Sliver版本
class SliverDelayedBuildUntilViewportWidget extends StatefulWidget {
  const SliverDelayedBuildUntilViewportWidget({
    super.key,
    required this.placeholderWidget,
    required this.child,
  });

  /// 从未进入过视口，占位渲染的组件，例如骨架屏、加载组件等
  final Widget placeholderWidget;

  /// 进入视口
  final Widget child;

  @override
  State<StatefulWidget> createState() => _SliverDelayedBuildUntilViewportState();
}

class _DelayedBuildUntilViewportState extends State<DelayedBuildUntilViewportWidget> {
  _DelayedBuildUntilViewportState();

  /// 是否从未进入过视口
  bool _isNeverEnteredViewport = true;

  @override
  Widget build(BuildContext context) {
    if (_isNeverEnteredViewport) {
      return VisibilityDetector(
        key: UniqueKey(),
        onVisibilityChanged: (visibilityInfo) {
          if (_isNeverEnteredViewport) {
            setState(() => _isNeverEnteredViewport = false);
          }
        },
        child: widget.placeholderWidget,
      );
    }
    return widget.child;
  }
}

class _SliverDelayedBuildUntilViewportState extends State<SliverDelayedBuildUntilViewportWidget> {
  _SliverDelayedBuildUntilViewportState();

  /// 是否从未进入过视口
  bool _isNeverEnteredViewport = true;

  @override
  Widget build(BuildContext context) {
    if (_isNeverEnteredViewport) {
      return SliverVisibilityDetector(
        key: UniqueKey(),
        onVisibilityChanged: (visibilityInfo) {
          if (_isNeverEnteredViewport) {
            setState(() => _isNeverEnteredViewport = false);
          }
        },
        sliver: widget.placeholderWidget,
      );
    }
    return widget.child;
  }
}
