import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/search/result/arguments/seach_filter_arguments.dart';

/// 搜索类型
final searchTypeProvider = StateProvider.autoDispose<SearchType>((ref) => SearchType.artwork);

/// 搜索的筛选
final searchFilterProvider = StateProvider.autoDispose<SearchFilterArguments>((ref) => const SearchFilterArguments());
