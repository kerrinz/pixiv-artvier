import 'package:flutter/material.dart';

class SizeReportingWidget extends StatefulWidget {
  final Widget child;

  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    super.key,
    required this.child,
    required this.onSizeChange,
  });

  @override
  State<StatefulWidget> createState() => _SizeReportingWidget();
}

class _SizeReportingWidget extends State<SizeReportingWidget> with AutomaticKeepAliveClientMixin {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _notifySizeChange());
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: ((notification) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _notifySizeChange());
        return true;
      }),
      child: SizeChangedLayoutNotifier(child: widget.child),
    );
  }

  _notifySizeChange() {
    if (!mounted) {
      return;
    }
    final size = context.size;
    if (size != null && _oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
