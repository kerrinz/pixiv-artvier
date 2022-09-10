import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class LocalizationIntl {
  static Future<LocalizationIntl> load(Locale locale) {
    final String name = locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return LocalizationIntl();
    });
  }

  static LocalizationIntl of(BuildContext context) {
    return Localizations.of<LocalizationIntl>(context, LocalizationIntl)!;
  }
  // 程序框架
  String get doubleBackToExit => Intl.message('Double back to exit.', name: 'doubleBackToExit', desc: '退出程序前的提示');
  String get navHome => Intl.message('Home', name: 'navHome', desc: '底部导航栏');
  String get navDiscover => Intl.message('Discover', name: 'navDiscover', desc: '底部导航栏');
  String get navDynamic => Intl.message('Dynamic', name: 'navDynamic', desc: '底部导航栏');
  String get navProfile => Intl.message('Profile', name: 'navProfile', desc: '底部导航栏');
  // 通用
  String get illustrations => Intl.message('illustrations', name: 'illustrations', desc: '作品类型选项');
  String get manga => Intl.message('Manga', name: 'manga', desc: '作品类型选项');
  String get novels => Intl.message('Novels', name: 'novels', desc: '作品类型选项');
  String get more => Intl.message('More', name: 'more', desc: '更多');
  String get viewMore => Intl.message('View more', name: 'viewMore', desc: '查看更多');
  // 首页
  String get rankings => Intl.message('Rankings', name: 'rankings', desc: '首页功能组按钮');
  String get dailyRankings => Intl.message('Daily Rankings', name: 'dailyRankings', desc: '首页的每日排行组件的标题');
  String get recommended => Intl.message('Recommended', name: 'recommended', desc: '首页的推荐组件的标题');
  // Profile页面
  String get following => Intl.message('Following', name: 'following', desc: '用户属性之一，统计数量');
  String get followers => Intl.message('Followers', name: 'followers', desc: '用户属性之一，统计数量');
  String get friends => Intl.message('Friends', name: 'friends', desc: '用户属性之一，统计数量');
  String get history => Intl.message('History', name: 'history', desc: '用户功能');
  String get downloads => Intl.message('Downloads', name: 'downloads', desc: '功能项，下载');
  String get artworks => Intl.message('Artworks', name: 'artworks', desc: '功能项，用户的作品');
  String get collections => Intl.message('Collections', name: 'collections', desc: '功能项，用户的收藏');
  String get markers => Intl.message('Markers', name: 'markers', desc: '功能项，表示小说的书签');
  String get submitWork => Intl.message('Submit Work', name: 'submitWork', desc: '投稿新作品的按钮');
}

class LocalizationIntlDelegate extends LocalizationsDelegate<LocalizationIntl> {
  const LocalizationIntlDelegate();
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<LocalizationIntl> load(Locale locale) {
    return LocalizationIntl.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationIntl> old) => false;
}
