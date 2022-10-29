import 'package:pixgem/common_provider/base_provider.dart';

/// 收藏的状态
enum BookmarkStatus {
  /// 请求收藏中
  bookmarking,

  /// 请求取消收藏
  unBookmarking,

  /// 已收藏
  bookmarked,

  /// 未收藏
  notBookmark,
}

class BookmarkStatusProvider extends BaseProvider {
  late BookmarkStatus bookmarkStatus; // 收藏状态

  BookmarkStatusProvider({
    required this.bookmarkStatus,
  });

  void setBookmarkStatus(BookmarkStatus status) {
    bookmarkStatus = status;
    notifyListeners();
  }
}
