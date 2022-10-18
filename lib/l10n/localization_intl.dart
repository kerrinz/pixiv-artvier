import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class LocalizationIntl {
  // App 支持的语言，不考虑countryCode
  static List<Locale> supportedLocales = const [
    Locale.fromSubtags(languageCode: "zh", scriptCode: "Hans"),
    Locale.fromSubtags(languageCode: "en"),
  ];

  static Future<LocalizationIntl> load(Locale locale) {
    final String localeName = Intl.canonicalizedLocale(locale.toString());
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return LocalizationIntl();
    });
  }

  static LocalizationIntl of(BuildContext context) {
    return Localizations.of<LocalizationIntl>(context, LocalizationIntl)!;
  }

  // 程序框架
  String get doubleBackToExitPrompt => Intl.message('Double back to confirm exit.',
      name: 'doubleBackToExitPrompt', desc: 'Prompt when click back on main page');
  String get navHome => Intl.message('Home', name: 'navHome', desc: 'BottomNavigationBar');
  String get navDiscover => Intl.message('Discover', name: 'navDiscover', desc: 'BottomNavigationBar');
  String get navDynamic => Intl.message('Dynamic', name: 'navDynamic', desc: 'BottomNavigationBar');
  String get navProfile => Intl.message('Profile', name: 'navProfile', desc: 'BottomNavigationBar');
  // 通用
  String get illustrations => Intl.message('illustrations', name: 'illustrations', desc: 'An option of artwork type');
  String get manga => Intl.message('Manga', name: 'manga', desc: 'An option of artwork type');
  String get novels => Intl.message('Novels', name: 'novels', desc: 'An option of artwork type');
  String get series => Intl.message("Series", name: 'series', desc: 'the badge or manga or novel series');
  String get more => Intl.message('More', name: 'more', desc: '');
  String get viewMore => Intl.message('View more', name: 'viewMore', desc: '');
  String get promptTitle => Intl.message('Prompt', name: 'promptTitle', desc: '');
  String get promptCancel => Intl.message('Cancel', name: 'promptCancel', desc: '');
  String get promptConform => Intl.message('Conform', name: 'promptConform', desc: '');
  String get all => Intl.message('All', name: 'all', desc: '');
  String get public => Intl.message('Public', name: 'public', desc: '');
  String get private => Intl.message('Private', name: 'private', desc: 'non-public');
  String get yes => Intl.message('Yes', name: 'yes', desc: '');
  String get not => Intl.message('Not', name: 'not', desc: '');
  String get loadingFailed => Intl.message('Loading Failed', name: 'loadingFailed', desc: 'Image loading failed');
  String get requestFailed => Intl.message('Request Failed', name: 'requestFailed', desc: 'Request data failed');
  String get retry => Intl.message('Retry', name: 'retry', desc: '');
  String get filter => Intl.message("Filter", name: 'filter', desc: 'filter the conditions for list');
  // 首页
  String get rankings => Intl.message('Rankings', name: 'rankings', desc: 'Function group item.');
  String get dailyRankings =>
      Intl.message('Daily Rankings', name: 'dailyRankings', desc: 'Title of ranking glance widget');
  String get recommended =>
      Intl.message('Recommended', name: 'recommended', desc: 'Title of recommended artwork list in home page');
  // Profile页面
  String get space => Intl.message('Space', name: 'space', desc: 'Navigate to my detail page');
  String get following => Intl.message('Following', name: 'following', desc: 'Show number of following');
  String get followers => Intl.message('Followers', name: 'followers', desc: 'Show number of followers');
  String get friends => Intl.message('Friends', name: 'friends', desc: 'Show number of friends(好P友)');
  String get history => Intl.message('History', name: 'history', desc: 'Function group item');
  String get downloads => Intl.message('Download', name: 'downloads', desc: 'Name of button in function group');
  String get works => Intl.message('Works', name: 'works', desc: 'Function group item. My created artwork');
  String get collections =>
      Intl.message('Collection', name: 'collections', desc: 'Function group item. User favorite works');
  String get markers => Intl.message('Markers', name: 'markers', desc: 'Function group item. Same as novel bookmark');
  String get submitWork => Intl.message('Submit Work', name: 'submitWork', desc: 'Submit new works');
  String get switchAccount => Intl.message('Switch account', name: 'switchAccount', desc: 'A preference item');
  String get quickSettingsTitle =>
      Intl.message('Quick settings', name: 'quickSettingsTitle', desc: 'The title of settings list');
  String get muteSettings =>
      Intl.message('Mute settings', name: 'muteSettings', desc: 'A preference item of hide certain users and tags');
  String get themeSettings => Intl.message('Theme settings', name: 'themeSettings', desc: 'A preference item');
  String get proxyAndOrigin => Intl.message('proxy & origin',
      name: 'proxyAndOrigin', desc: 'A preference item of configure network proxy and image origin');
  String get otherSettings => Intl.message('Other settings', name: 'otherSettings', desc: 'A preference item');
  String get themeModePromptContent =>
      Intl.message('Manually switching theme mode will turn off the auto-follow system mode, are you sure to switch?',
          name: 'themeModePromptContent',
          desc: 'Switch theme mode in tool bar when currently in auto-follow system mode');
  // 用户详情页
  String get follow => Intl.message('Follow', name: 'follow', desc: '');
  String get followed => Intl.message('Followed', name: 'followed', desc: '');
  String get textCollapse => Intl.message('Collapse', name: 'textCollapse', desc: '');
  String get textExpand => Intl.message('Expand', name: 'textExpand', desc: '');
  String get gender => Intl.message('Gender', name: 'gender', desc: '');
  String get male => Intl.message('Male', name: 'male', desc: '');
  String get female => Intl.message('Female', name: 'female', desc: '');
  String get age => Intl.message('Age', name: 'age', desc: '');
  String get birthday => Intl.message('Birthday', name: 'birthday', desc: '');
  String get occupation => Intl.message('Occupation', name: 'occupation', desc: '');
  String get workspace => Intl.message('Workspace', name: 'workspace', desc: '');
  String get computer => Intl.message('Computer', name: 'computer', desc: '');
  String get monitor => Intl.message('Monitor', name: 'monitor', desc: '');
  String get softwareUsed => Intl.message('Software Used', name: 'softwareUsed', desc: 'Drawing software');
  String get scanner => Intl.message('Scanner', name: 'scanner', desc: '');
  String get tablet => Intl.message('Graphic tablet', name: 'tablet', desc: 'Drawing equipment');
  String get mouse => Intl.message('Mouse', name: 'mouse', desc: '');
  String get printer => Intl.message('Printer', name: 'printer', desc: '');
  String get onYourDesk => Intl.message('On top of your desk', name: 'onYourDesk', desc: 'Something on your desk');
  String get backgroundMusic =>
      Intl.message('Background music', name: 'backgroundMusic', desc: 'The background music when you drawing');
  String get table => Intl.message('Table', name: 'table', desc: '');
  String get chair => Intl.message('Chair', name: 'chair', desc: '');
  String get other => Intl.message('Other', name: 'other', desc: '');
  String get nickname => Intl.message('Nickname', name: 'nickname', desc: '');
  String get website => Intl.message('Website', name: 'website', desc: '');
  String get socialMedia => Intl.message('Social Media', name: 'socialMedia', desc: '');
  String get location => Intl.message('Location', name: 'location', desc: 'country or region');
  String get copiedToClipboard => Intl.message('Copied to clipboard', name: 'copiedToClipboard', desc: '');
  String get emptyWorksPlaceholder => Intl.message("It is empty here",
      name: 'emptyWorksPlaceholder', desc: 'Placeholder the works list when it is empty');
  String get pixivPremium => Intl.message("Pixiv Premium", name: 'pixivPremium', desc: '');
  // 我的收藏页面
  String get myCollections => Intl.message("My collections", name: 'myCollections', desc: '');
}

class LocalizationIntlDelegate extends LocalizationsDelegate<LocalizationIntl> {
  const LocalizationIntlDelegate();
  @override
  // 这里的 locale 是App当前的locale.
  bool isSupported(Locale locale) => LocalizationIntl.supportedLocales.contains(locale);

  @override
  Future<LocalizationIntl> load(Locale locale) {
    return LocalizationIntl.load(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<LocalizationIntl> old) => false;
}
