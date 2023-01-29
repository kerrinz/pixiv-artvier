import 'package:flutter/widgets.dart';

/// 偏好设置的容器，可搭配 [PerferenceGroup], [PerferenceItem] 使用
class PerferenceContainer extends StatelessWidget {
  const PerferenceContainer({
    super.key,
    required this.groups,
  });

  /// [PerferenceGroup] List
  final List<Widget> groups;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: groups,
      ),
    );
  }
}
