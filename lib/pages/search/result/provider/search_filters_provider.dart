import 'package:artvier/pages/main_navigation_tab_page/search/provider/trend_tags_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/search/result/arguments/seach_filter_arguments.dart';

const _searchTypeMap = {
  WorksType.illust: SearchType.artwork,
  WorksType.manga: SearchType.artwork,
  WorksType.mangaSeries: SearchType.artwork,
  WorksType.novel: SearchType.novel,
};

/// 搜索类型
final searchTypeProvider = StateProvider.autoDispose<SearchType>((ref) {
  final trendTagsWorksType = ref.read(trendTagsWorksTypeProvider);

  return _searchTypeMap[trendTagsWorksType] ?? SearchType.artwork;
});

/// 搜索的筛选
final searchFilterProvider = StateProvider.autoDispose<SearchFilterArguments>((ref) => const SearchFilterArguments());
