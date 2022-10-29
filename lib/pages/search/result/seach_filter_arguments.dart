class SearchFilterArguments {
  /// 最小收藏数（非会员，关键字方式）
  int? minCollectCount;

  /// 日期
  DateTime? date;

  SearchFilterArguments({
    this.minCollectCount,
    this.date,
  });
}
