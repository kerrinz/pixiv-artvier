import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/user/collection/model/collections_filter_model.dart';

/// 收藏作品的筛选条件（会影响收藏作品列表）
final collectionsFilterProvider = StateProvider.autoDispose<CollectionsFilterModel>(
  (ref) => const CollectionsFilterModel(worksType: WorksType.illust),
);

/// 缓存临时的收藏作品的筛选条件（只会影响标签列表）
final cachedCollectionsFilterProvider = StateProvider.autoDispose<CollectionsFilterModel>(
  (ref) => ref.watch(collectionsFilterProvider),
);
