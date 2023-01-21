import 'package:flutter/widgets.dart';
import 'package:pixgem/pages/account/account_manage/account_manage_page.dart';
import 'package:pixgem/pages/comment/comments_tabpage.dart';
import 'package:pixgem/pages/artwork/download_manage/download_manage_page.dart';
import 'package:pixgem/pages/artwork/history/history_page.dart';
import 'package:pixgem/pages/artwork/detail/detail_page.dart';
import 'package:pixgem/pages/artwork/ranking/artworks_ranking_page.dart';
import 'package:pixgem/pages/artwork/preview/illust_preview_page.dart';
import 'package:pixgem/pages/login/login_by_web_page.dart';
import 'package:pixgem/pages/login/login_wizard_page.dart';
import 'package:pixgem/pages/main_navigation_tab_page/main_navigation.dart';
import 'package:pixgem/pages/framework/not_found/not_found_page.dart';
import 'package:pixgem/pages/search/result/search_result_page.dart';
import 'package:pixgem/pages/settings/download/download_setting.dart';
import 'package:pixgem/pages/settings/language/language_setting.dart';
import 'package:pixgem/pages/user/collection/my_collection_page.dart';
import 'package:pixgem/pages/user/following/user_following_page.dart';
import 'package:pixgem/pages/user/detail/user_detail_page.dart';
import 'package:pixgem/pages/user/works/my_works.dart';

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
  ranking,
  artworkDetail,

  /// 作品大图预览
  artworkImagesPreview,

  /// 全部评论
  comments,

  userFollowing,
  userDetail,
  searchResult,
  myBookmarks,
  myWorks,

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
    RouteNames.notFound.name: (context, arguments) => const NotFoundPage(),
    RouteNames.mainNavigation.name: (context, arguments) => const MainNavigation(),
    RouteNames.wizard.name: (context, arguments) => const LoginWizardPage(),
    RouteNames.loginWeb.name: (context, arguments) => const LoginWebPage(),
    RouteNames.ranking.name: (context, arguments) => const ArtworksRankingPage(),
    RouteNames.artworkDetail.name: (context, arguments) => ArtWorksDetailPage(arguments!),
    RouteNames.artworkImagesPreview.name: (context, arguments) => PreviewArtworksPage(arguments!),
    RouteNames.comments.name: (context, arguments) => CommentsPage(arguments!),
    RouteNames.userFollowing.name: (context, arguments) => UserFollowingPage(arguments!),
    RouteNames.userDetail.name: (context, arguments) => UserDetailPage(arguments!),
    RouteNames.searchResult.name: (context, arguments) => SearchResultPage(arguments!),
    RouteNames.myBookmarks.name: (context, arguments) => MyBookmarksPage(arguments!),
    RouteNames.myWorks.name: (context, arguments) => MyWorksPage(arguments),
    RouteNames.history.name: (context, arguments) => const ViewHistoryPage(),
    RouteNames.accountManage.name: (context, arguments) => const AccountManagePage(),
    RouteNames.downloadManage.name: (context, arguments) => const DownloadManagePage(),
    RouteNames.downloadSettings.name: (context, arguments) => const SettingDownload(),
    RouteNames.languageSettings.name: (context, arguments) => const LanguageSettingPage(),
  };

  static RouteWidgetBuilder match(BuildContext context, String? name) {
    return routes[name] ?? (context, arguments) => const NotFoundPage();
  }
}
