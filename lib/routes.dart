import 'package:flutter/widgets.dart';
import 'package:pixgem/pages/account/account_manage/account_manage_page.dart';
import 'package:pixgem/pages/comment/comments_page.dart';
import 'package:pixgem/pages/illust/download_manage/download_manage_page.dart';
import 'package:pixgem/pages/illust/history/history_page.dart';
import 'package:pixgem/pages/illust/illust_detail/illust_detail_page.dart';
import 'package:pixgem/pages/illust/leaderboard/illust_leaderboard_page.dart';
import 'package:pixgem/pages/illust/preview/illust_preview_page.dart';
import 'package:pixgem/pages/login/login_by_web_page.dart';
import 'package:pixgem/pages/login/login_wizard_page.dart';
import 'package:pixgem/pages/main_navigation.dart';
import 'package:pixgem/pages/search/result/search_result_page.dart';
import 'package:pixgem/pages/settings/download/download_setting.dart';
import 'package:pixgem/pages/settings/language/language_setting.dart';
import 'package:pixgem/pages/user/bookmark/my_bookmarks.dart';
import 'package:pixgem/pages/user/following/user_following_page.dart';
import 'package:pixgem/pages/user/user_detail/user_detail_page.dart';

/// [WidgetBuilder] 的改造版，增加传参：[RouteSettings.arguments] 
typedef RouteWidgetBuilder = Widget Function(BuildContext context, Object? arguments);

enum RouteNames {
  /// 找不到页面时跳转到此
  notFound,

  /// 程序主页面，带有底部导航栏
  mainNavigation,

  /// 引导页
  wizard,

  loginWeb,
  leaderboard,
  artworkDetail,

  /// 作品大图预览
  artworkImagesPreview,

  /// 全部评论
  comments,

  userFollowing,
  userDetail,
  searchResult,
  myBookmarks,

  /// 足迹
  history,

  accountManage,
  downloadManage,
  downloadSettings,
  themeSettings,
  networkSettings,
  languageSettings,
}

class RouteItem<T> {}

class Routes {
  static var routes = <String, RouteWidgetBuilder>{
    RouteNames.notFound.name: (context, arguments) => const MainNavigation(),
    RouteNames.mainNavigation.name: (context, arguments) => const MainNavigation(),
    RouteNames.wizard.name: (context, arguments) => const LoginWizardPage(),
    RouteNames.loginWeb.name: (context, arguments) => const LoginWebPage(),
    RouteNames.leaderboard.name: (context, arguments) => const ArtworksLeaderboardPage(),
    RouteNames.artworkDetail.name: (context, arguments) => ArtWorksDetailPage(arguments!),
    RouteNames.artworkImagesPreview.name: (context, arguments) => PreviewArtworksPage(arguments!),
    RouteNames.comments.name: (context, arguments) => CommentsPage(arguments!),
    RouteNames.userFollowing.name: (context, arguments) => UserFollowingPage(arguments!),
    RouteNames.userDetail.name: (context, arguments) => UserDetailPage(arguments!),
    RouteNames.searchResult.name: (context, arguments) => SearchResultPage(arguments!),
    RouteNames.myBookmarks.name: (context, arguments) => MyBookmarksPage(arguments),
    RouteNames.history.name: (context, arguments) => ViewHistoryPage(),
    RouteNames.accountManage.name: (context, arguments) => const AccountManagePage(),
    RouteNames.downloadManage.name: (context, arguments) => const DownloadManagePage(),
    RouteNames.downloadSettings.name: (context, arguments) => const SettingDownload(),
    RouteNames.languageSettings.name: (context, arguments) => const LanguageSettingPage(),
  };

  static RouteWidgetBuilder match(BuildContext context, String? name) {
    return routes[name] ?? (context, arguments) => const MainNavigation();
  }
}
