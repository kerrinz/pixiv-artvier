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
  String get more => Intl.message('More', name: 'more', desc: '');
  String get viewMore => Intl.message('View more', name: 'viewMore', desc: '');
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
  String get promptTitle => Intl.message('Prompt', name: 'promptTitle', desc: '');
  String get promptCancel => Intl.message('Cancel', name: 'promptCancel', desc: '');
  String get promptConform => Intl.message('Conform', name: 'promptConform', desc: '');
  String get themeModePromptContent =>
      Intl.message('Manually switching theme mode will turn off the auto-follow system mode, are you sure to switch?',
          name: 'themeModePromptContent',
          desc: 'Switch theme mode in tool bar when currently in auto-follow system mode');
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
