import 'dart:async';

/// 事件工具
class EventUtil {
  static const kEventDuration = 300;
  static Timer? timer;

  // 防抖
  static debounce(Function callback, {durationTime = kEventDuration}) {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: durationTime), () {
      callback.call();
      timer = null;
    });
  }

  static const String deFaultThrottleId = 'DeFaultThrottleId';
  static Map<String, int> startTimeMap = {deFaultThrottleId: 0};

  /// 节流
  static throttle(Function callback,
      {String throttleId = deFaultThrottleId, durationTime = kEventDuration, Function? continueClick}) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - (startTimeMap[throttleId] ?? 0) > durationTime) {
      callback.call();
      startTimeMap[throttleId] = DateTime.now().millisecondsSinceEpoch;
    } else {
      continueClick?.call();
    }
  }
}

// 扩展Function，添加防抖功能
extension DebounceExtension on Function {
  void Function() debounce([int milliseconds = 500]) {
    Timer? debounceTimer;
    return () {
      if (debounceTimer?.isActive ?? false) debounceTimer?.cancel();
      debounceTimer = Timer(Duration(milliseconds: milliseconds), this());
    };
  }
}

// 扩展Function，添加节流功能
extension ThrottleExtension on Function {
  void Function() throttle([int milliseconds = 500]) {
    bool isAllowed = true;
    Timer? throttleTimer;
    return () {
      if (!isAllowed) return;
      isAllowed = false;
      this();
      throttleTimer?.cancel();
      throttleTimer = Timer(Duration(milliseconds: milliseconds), () {
        isAllowed = true;
      });
    };
  }
}
