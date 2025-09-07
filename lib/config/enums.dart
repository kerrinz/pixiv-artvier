/// 页面所处的状态
enum PageState {
  /// 首次加载中
  loading,

  /// 刷新中（非首次加载）
  refreshing,

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
  /// 未知状态，加载中
  loading,

  /// 请求收藏中
  collecting,

  /// 请求取消收藏
  uncollecting,

  /// 已收藏
  collected,

  /// 未收藏
  notCollect,
}

///书签状态
enum MarkerState {
  /// 请求添加书签中
  addingMarker,

  /// 请求取消书签
  removingMarker,

  /// 已加书签
  marked,

  /// 未加书签
  unmarked,
}

/// 用户关注状态
enum UserFollowState {
  /// 请求关注中
  requestingFollow,

  /// 请求取消关注
  requestingUnfollow,

  /// 已关注
  followed,

  /// 未关注
  notFollow,
}

/// 作品类型
enum WorksType {
  illust,
  manga,
  mangaSeries,
  novel,
}

/// 隐私（可见性）限制
enum Restrict {
  /// 公开的
  public,

  /// 非公开的
  private,
}

/// 隐私（可见性）限制，完整版
enum RestrictAll {
  /// 全部
  all,

  /// 公开的
  public,

  /// 非公开的
  private,
}

/// 下载（保存）状态
enum DownloadState {
  /// 下载中
  downloading,

  /// 暂停
  paused,

  /// 下载失败
  failed,

  /// 等待中
  waiting,

  /// 下载成功
  success,
}

/// 下载资源类型
enum DownloadType {
  illust,
  manga,
}

/// 搜索类型
enum SearchType {
  artwork,
  novel,
  user,
}
