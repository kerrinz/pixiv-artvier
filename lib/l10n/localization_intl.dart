import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class LocalizationIntl {
  // App 支持的语言，不考虑countryCode
  static List<Locale> supportedLocales = const [
    Locale("zh", "CN"),
    Locale("en", "US"),
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

  // 引导页
  String get tokenLogin => Intl.message('Token change', name: 'tokenLogin', desc: 'Button and title of login by token');
  String get webLogin => Intl.message('Web login', name: 'webLogin', desc: 'Button and title of login by web');
  String get login => Intl.message('Login', name: 'login', desc: 'An action of login account');
  String get loginSuccess =>
      Intl.message('Login success!', name: 'loginSuccess', desc: 'Toast message when login success');
  String get loginFailed => Intl.message('Login failed!', name: 'loginFailed', desc: 'Toast message when login failed');

  // 程序框架
  String get doubleBackToExitPrompt => Intl.message('Double back to confirm exit.',
      name: 'doubleBackToExitPrompt', desc: 'Prompt when click back on main page');
  String get navHome => Intl.message('Home', name: 'navHome', desc: 'BottomNavigationBar');
  String get navDiscover => Intl.message('Discover', name: 'navDiscover', desc: 'BottomNavigationBar');
  String get navDynamic => Intl.message('Dynamic', name: 'navDynamic', desc: 'BottomNavigationBar');
  String get navProfile => Intl.message('Profile', name: 'navProfile', desc: 'BottomNavigationBar');
  // 通用
  String get account => Intl.message('Account', name: 'account', desc: 'Title of user account');
  String get illust => Intl.message('Illust', name: 'illust', desc: 'An option of works type');
  String get manga => Intl.message('Manga', name: 'manga', desc: 'An option of works type');
  String get novels => Intl.message('Novels', name: 'novels', desc: 'An option of works type');
  String get users => Intl.message('Users', name: 'users', desc: 'a search type');
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
  String get requestFailed =>
      Intl.message('Poor network, please try reloading', name: 'requestFailed', desc: 'Request failed');
  String get retryOnFailure =>
      Intl.message('Click to try again', name: 'retryOnFailure', desc: 'Text of retry button for failed requests');
  String get filter => Intl.message("Filter", name: 'filter', desc: 'filter the conditions for list');
  String get settings => Intl.message('Settings', name: 'settings', desc: '');
  String get softwareUpdate => Intl.message('Software update', name: 'softwareUpdate', desc: '');
  String get aboutApp =>
      Intl.message('About app', name: 'aboutApp', desc: 'Button link or page title to about app page');
  String get openLinkHint => Intl.message('Do you want to open this link?',
      name: 'openLinkHint', desc: 'Hint before open the link using an external browser');
  String get appShortTermsTitle =>
      Intl.message('By using the Software, you agree to the following terms:', name: 'appShortTermsTitle', desc: '');
  String get appShortTerms => Intl.message(
      '1. This software is free of charge and is only for learning and communication use, and may not be used for any other purpose (especially not for commercial purposes), and the legal liability for any other use shall not be borne by me.\n2. This software will not be available for download anywhere other than the Github repository, please comply with local laws and regulations, and you shall bear the legal responsibility for downloading and distributing this software.\n3. If access to the official Pixiv website is not supported in your current country or region, you will also not be able to use and will not be permitted to use the Software.\n4. This software does not set up a server and does not provide resources and services, all network data in the software comes from Pixiv\'s official interface, and the copyright of all works (including illustrations, comics, novels, etc.) belongs to Pixiv or the original author.',
      name: 'appShortTerms',
      desc: '');

  // 深色模式、主题相关
  String get lightBrightness => Intl.message("Light", name: 'lightBrightness', desc: 'Light brightness for app');
  String get dartBrightness => Intl.message("Dark", name: 'dartBrightness', desc: 'Dark brightness for app');
  String get dartModeSettingsTitle =>
      Intl.message("Dark Mode Settings", name: 'dartModeSettingsTitle', desc: 'The settings title of dark mode');
  String get autoSwitchFollowingSystem => Intl.message("Auto switch following system",
      name: 'autoSwitchFollowingSystem', desc: 'The options title for brightness following system');
  String get autoSwitchFollowingSystemDesc =>
      Intl.message("Automatically switch between light and dark following the system settings",
          name: 'autoSwitchFollowingSystemDesc', desc: 'The description of options of following system');

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
  String get networkSettings =>
      Intl.message('Network settings', name: 'networkSettings', desc: 'A preference item of configure network');
  String get otherSettings => Intl.message('Other settings', name: 'otherSettings', desc: 'A preference item');
  String get themeModePromptContent =>
      Intl.message('Manually switching theme mode will turn off the auto-follow system mode, are you sure to switch?',
          name: 'themeModePromptContent',
          desc: 'Switch theme mode in tool bar when currently in auto-follow system mode');
  // 设置
  String get accountManage => Intl.message('Account manage', name: 'accountManage', desc: 'Manage all of my accounts');
  String get defaultNoProxy => Intl.message('No proxy (default)', name: 'defaultNoProxy', desc: '');
  String get customProxy => Intl.message('Custom proxy', name: 'customProxy', desc: '');
  String get enableDirectConnection =>
      Intl.message('Enable direct connection (preview)', name: 'enableDirectConnection', desc: '');
  String get directConnectionHint =>
      Intl.message('This feature does not currently support login by web', name: 'directConnectionHint', desc: '');
  String get appVersion => Intl.message('App version', name: 'appVersion', desc: '');
  String get currentVersion => Intl.message('Current version', name: 'currentVersion', desc: '');
  String get changelog => Intl.message('Changelog', name: 'changelog', desc: '');
  String get downloadLink => Intl.message('Download link', name: 'downloadLink', desc: '');
  String get currentIsLatestVersion => Intl.message('It is currently the latest version',
      name: 'currentIsLatestVersion', desc: 'Check update result is currently lastest version');
  String get checkUpdateLimitForGithubApi => Intl.message(
      'The number of Github API access times exceeds the limit, please try again in one hour, or manually access the project address: ',
      name: 'checkUpdateLimitForGithubApi',
      desc: '');
  String get appAuthor => Intl.message('Author', name: 'appAuthor', desc: '');
  String get appProjectLink => Intl.message('Project link', name: 'appProjectLink', desc: '');
  String get proxySettingsTitle => Intl.message('HTTP Proxy settings', name: 'proxySettingsTitle', desc: '');
  String get proxySettingsTitleHint =>
      Intl.message('(The proxy settings do not take effect for logins)', name: 'proxySettingsTitleHint', desc: '');
  String get ipAdressEditing => Intl.message('IP adress:', name: 'ipAdressEditing', desc: '');
  String get portEditing => Intl.message('Port:', name: 'portEditing', desc: '');
  String get customImageHosting => Intl.message('Custom image hosting', name: 'customImageHosting', desc: '');
  String get editImageHosting => Intl.message('Edit image hosting', name: 'editImageHosting', desc: '');

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
  // 画作详情页
  String get addToCollections =>
      Intl.message("Add to collections", name: 'addToCollections', desc: 'Title of add works to colllections');
  String get editCollection =>
      Intl.message("Edit collection", name: 'editCollection', desc: 'Title of edit the colllection');
  String get privacyRestrict =>
      Intl.message("Privacy restrict", name: 'privacyRestrict', desc: 'Settings the rescriction of works');
  String get attachTags => Intl.message("Attach tags", name: 'attachTags', desc: 'Attach tags when collecting a works');
  String get addCollectSucceed =>
      Intl.message("Add collection succeed!", name: 'addCollectSucceed', desc: 'Prompt success of add collect a works');
  String get addCollectFailed =>
      Intl.message("Add collestion failed!", name: 'addCollectFailed', desc: 'Prompt failed of add collect a works');
  String get removeCollectionSucceed => Intl.message("Remove collection succeed!",
      name: 'removeCollectionSucceed', desc: 'Prompt success of remove collection of a works');
  String get removeCollectionFailed => Intl.message("Remove collection failed!",
      name: 'removeCollectionFailed', desc: 'Prompt failed of remove collection of a works');
  String get editCollectionSucceed => Intl.message("Edit collection succeed!",
      name: 'editCollectionSucceed', desc: 'Prompt of edit collection success');
  String get editCollectionFailed =>
      Intl.message("Edit collection failed!", name: 'editCollectionFailed', desc: 'Prompt of edit collection failed');
  String get addNewTagPlaceholder => Intl.message("Add new tag...",
      name: 'addNewTagPlaceholder', desc: 'The placeholder of input tag name to add a new tag');
  String get tagAlreadyExists => Intl.message("Tag already exists!",
      name: 'tagAlreadyExists', desc: 'Prompt the tag already exists by add new tag');
  String get tagsReachedMaximun => Intl.message("Maximum number of tags reached!",
      name: 'tagsReachedMaximun', desc: 'Prompt when no more tags are allowed');

  // 排行榜
  String get rankingDaily => Intl.message("Daily", name: 'rankingDaily', desc: '');
  String get rankingWeekly => Intl.message("Weekly", name: 'rankingWeekly', desc: '');
  String get rankingMonthly => Intl.message("Monthly", name: 'rankingMonthly', desc: '');
  String get rankingMale => Intl.message("Male", name: 'rankingMale', desc: '');
  String get rankingFemale => Intl.message("Female", name: 'rankingFemale', desc: '');
  String get rankingOriginal => Intl.message("Original", name: 'rankingOriginal', desc: '');
  String get rankingRookie => Intl.message("Rookie", name: 'rankingRookie', desc: '');
  String get rankingAiGenerated => Intl.message("AI-generated", name: 'rankingAiGenerated', desc: '');
  String get rankingR18AiGenerated => Intl.message("R-18 AI-generated", name: 'rankingR18AiGenerated', desc: '');
  String get rankingR18Daily => Intl.message("R18 Daily", name: 'rankingR18Daily', desc: '');
  String get rankingR18Weekly => Intl.message("R18 Weekly", name: 'rankingR18Weekly', desc: '');
  String get rankingR18Male => Intl.message("R18 Male", name: 'rankingR18Male', desc: '');
  String get rankingR18Female => Intl.message("R18 Female", name: 'rankingR18Female', desc: '');

  // 搜索
  String get search => Intl.message("Search", name: 'search', desc: 'Verb or noun of <search>');
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
