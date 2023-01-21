import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 搜索输入框（还没进入搜索结果页）
final searchInputProvider = StateProvider.autoDispose<String>((ref) => "");
