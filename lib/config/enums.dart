/// 页面所处的状态
enum PageState {
  /// 加载中
  loading,

  /// 完成（且非空）
  complete,

  /// 完成但空内容
  empty,

  /// 加载出错
  error,
}

/// 懒加载的状态
enum LazyloadState {
  /// 闲置；此时并未滚动到底，但还有数据未加载
  idle,

  /// 正在加载数据中；此时应该拦截重复触发的加载请求
  loading,

  /// 没有更多了
  noMore,

  /// 懒加载出错
  error,
}

/// 收藏状态
enum CollectState {
  /// 请求收藏中
  collecting,

  /// 请求取消收藏
  uncollecting,

  /// 已收藏
  collected,

  /// 未收藏
  notCollect,
}

enum WorksType {
  illust,
  manga,
  mangaSeries,
  novel,
}

/// 限制范围
enum Reveal {
  /// 全部
  all,

  /// 公开的
  public,

  /// 非公开的
  private,
}
