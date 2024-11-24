import 'package:artvier/pages/artwork/pixivision/illust_pixivision_page.dart';
import 'package:artvier/pages/artwork/series/manga_series_detail_page.dart';
import 'package:artvier/pages/novel/detail/detail_page.dart';
import 'package:artvier/pages/novel/series/novel_series_detail_page.dart';
import 'package:artvier/pages/search/expand_search/expand_search_page.dart';
import 'package:artvier/pages/settings/about/about_app_page.dart';
import 'package:artvier/pages/settings/all_settings/all_settings_page.dart';
import 'package:artvier/pages/settings/check_update/check_update.dart';
import 'package:artvier/pages/settings/develop/developer_page.dart';
import 'package:flutter/widgets.dart';
import 'package:artvier/pages/account/account_manage/account_manage_page.dart';
import 'package:artvier/pages/comment/comments_page.dart';
import 'package:artvier/pages/artwork/download_manage/download_manage_page.dart';
import 'package:artvier/pages/artwork/history/history_page.dart';
import 'package:artvier/pages/artwork/detail/detail_page.dart';
import 'package:artvier/pages/artwork/ranking/artworks_ranking_page.dart';
import 'package:artvier/pages/artwork/viewer/image_viewer_page.dart';
import 'package:artvier/pages/login/login_by_web_page.dart';
import 'package:artvier/pages/login/login_wizard_page.dart';
import 'package:artvier/pages/main_navigation_tab_page/main_navigation.dart';
import 'package:artvier/pages/framework/not_found/not_found_page.dart';
import 'package:artvier/pages/search/result/search_result_page.dart';
import 'package:artvier/pages/settings/download/download_setting.dart';
import 'package:artvier/pages/settings/language/language_setting.dart';
import 'package:artvier/pages/user/collection/my_collection_page.dart';
import 'package:artvier/pages/user/following/user_following_page.dart';
import 'package:artvier/pages/user/detail/user_detail_page.dart';
import 'package:artvier/pages/user/works/my_works.dart';

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

  // 插画或漫画
  artworkDetail,
  artworkPixivition,

  // 漫画
  mangaSeriesDetail,

  // 小说
  novelDetail,
  novelSeriesDetail,

  /// 作品大图预览
  artworkImagesPreview,

  /// 全部评论
  comments,

  userFollowing,
  userDetail,
  /// 搜索框展开页
  expandSearch,
  searchResult,
  myBookmarks,
  myWorks,

  /// 足迹
  history,

  accountManage,
  downloadManage,


  allSettings,
  downloadSettings,
  themeSettings,
  networkSettings,
  languageSettings,
  developerSettings,
  aboutApp,
  checkUpdate,
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
    RouteNames.artworkImagesPreview.name: (context, arguments) => ImageViewerPage(arguments!),
    RouteNames.artworkPixivition.name: (context, arguments) => IllustPixivisionPage(arguments!),
    RouteNames.mangaSeriesDetail.name: (context, arguments) => MangaSeriesDetailPage(arguments!),
    RouteNames.novelDetail.name: (context, arguments) => NovelDetailPage(arguments!),
    RouteNames.novelSeriesDetail.name: (context, arguments) => NovelSeriesDetailPage(arguments!),
    RouteNames.comments.name: (context, arguments) => CommentsPage(arguments!),
    RouteNames.userFollowing.name: (context, arguments) => UserFollowingPage(arguments!),
    RouteNames.userDetail.name: (context, arguments) => UserDetailPage(arguments!),
    RouteNames.expandSearch.name: (context, arguments) => const ExpandSearchPage(),
    RouteNames.searchResult.name: (context, arguments) => SearchResultPage(arguments!),
    RouteNames.myBookmarks.name: (context, arguments) => MyBookmarksPage(arguments!),
    RouteNames.myWorks.name: (context, arguments) => MyWorksPage(arguments),
    RouteNames.history.name: (context, arguments) => const ViewHistoryPage(),
    RouteNames.accountManage.name: (context, arguments) => const AccountManagePage(),
    RouteNames.downloadManage.name: (context, arguments) => const DownloadManagePage(),
    RouteNames.allSettings.name: (context, arguments) => const AllSettingsPage(),
    RouteNames.downloadSettings.name: (context, arguments) => const SettingDownload(),
    RouteNames.languageSettings.name: (context, arguments) => const LanguageSettingPage(),
    RouteNames.developerSettings.name: (context, arguments) => const DeveloperPage(),
    RouteNames.aboutApp.name: (context, arguments) => const AboutAppPage(),
    RouteNames.checkUpdate.name: (context, arguments) => const CheckUpdatePage(),
  };

   static RouteWidgetBuilder match(BuildContext context, String? name) {
    return routes[name] ?? (context, arguments) => const NotFoundPage();
  }
}
