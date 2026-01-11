// ignore_for_file: constant_identifier_names

import 'package:artvier/global/model/novel_viewer/novel_viewer_settings_model.dart';
import 'package:artvier/l10n/localization_intl.dart';

class CONSTANTS {
  static const String mode_all = "all";
  static const String mode_safe = "safe";
  static const String mode_r18 = "r18";

  static const String type_illusts = "illust";
  static const String type_manga = "manga";

  /// 作品可见范围的匹配规则：**全部**
  /// - 支持：关注用户的新作
  /// - 不支持：用户的收藏
  static const String restrict_all = "all";

  /// 作品可见范围的匹配规则：**公开**
  static const String restrict_public = "public";

  /// 作品可见范围的匹配规则：**非公开**
  static const String restrict_private = "private";

  static const String referer = "https://www.pixiv.net/";
  static const String appApiReferer = "https://app-api.pixiv.net/";
  static const String referer_artworks_base = "https://www.pixiv.net/artworks/";
  static const String referer_users_base = "https://www.pixiv.net/users/";
  static const String stamp_url_base = "https://s.pximg.net/common/images/stamp/generated-stamps/"; // 用于表情图片的显示
  static const String pixiv_host_url = "https://www.pixiv.net";
  static const String pixiv_account_url = "https://accounts.pixiv.net";
  static const String novel_share_url = "https://www.pixiv.net/novel/show.php?id=";

  static const String proxy_default_host = "127.0.0.1";
  static const String proxy_default_port = "1080";

  static const String default_language_code = "en";
  static const String default_country_code = "US";

  // App information
  static const String app_repo_url = "https://github.com/kerrinz/pixiv-artvier";
  static const String app_repo_release_url = "$app_repo_url/releases";
  static const String app_repo_api = "https://api.github.com/repos/kerrinz/pixiv-artvier";
  static const String app_author = "Kerrinz";
  static const String app_author_url = "https://github.com/kerrinz";

  // Emoji
  static const Map<String, String> emojiMap = {
    "101": "normal",
    "102": "surprise",
    "103": "serious",
    "104": "heaven",
    "105": "happy",
    "106": "excited",
    "107": "sing",
    "108": "cry",
    "201": "normal2",
    "202": "shame2",
    "203": "love2",
    "204": "interesting2",
    "205": "blush2",
    "206": "fire2",
    "207": "angry2",
    "208": "shine2",
    "209": "panic2",
    "301": "normal3",
    "302": "satisfaction3",
    "303": "surprise3",
    "304": "smile3",
    "305": "shock3",
    "306": "gaze3",
    "307": "wink3",
    "308": "happy3",
    "309": "excited3",
    "310": "love3",
    "401": "normal4",
    "402": "surprise4",
    "403": "serious4",
    "404": "love4",
    "405": "shine4",
    "406": "sweat4",
    "407": "shame4",
    "408": "sleep4",
    "501": "heart",
    "502": "teardrop",
    "503": "star",
  };

  // Sticker
  static const Map<String, int> stickerMap = {
    "301_s": 301,
    "302_s": 302,
    "303_s": 303,
    "304_s": 304,
    "305_s": 305,
    "306_s": 306,
    "307_s": 307,
    "308_s": 308,
    "309_s": 309,
    "310_s": 310,
    "401_s": 401,
    "402_s": 402,
    "403_s": 403,
    "404_s": 404,
    "405_s": 405,
    "406_s": 406,
    "407_s": 407,
    "408_s": 408,
    "409_s": 409,
    "410_s": 410,
    "201_s": 201,
    "202_s": 202,
    "203_s": 203,
    "204_s": 204,
    "205_s": 205,
    "206_s": 206,
    "207_s": 207,
    "208_s": 208,
    "209_s": 209,
    "210_s": 210,
    "101_s": 101,
    "102_s": 102,
    "103_s": 103,
    "104_s": 104,
    "105_s": 105,
    "106_s": 106,
    "107_s": 107,
    "108_s": 108,
    "109_s": 109,
    "110_s": 110,
  };

  /// 小说阅读器的预设配色主题
  static Map<String, NovelViewerPresetTheme> viewerThemes(context) {
    final l10n = LocalizationIntl.of(context);
    return {
      "default": NovelViewerPresetTheme(
        name: l10n.default_,
        theme: null,
      ),
      "custom": NovelViewerPresetTheme(
        name: l10n.custom,
        theme: null,
      ),
      "snow_white": NovelViewerPresetTheme(
        theme: NovelViewerTheme(foreground: 0xff333333, background: 0xffffffff),
      ), // 白雪
      "gray_green": NovelViewerPresetTheme(
        theme: NovelViewerTheme(foreground: 0xff333333, background: 0xffd8e7eb),
      ), // 灰绿
      "grass_green": NovelViewerPresetTheme(
        theme: NovelViewerTheme(foreground: 0xff333333, background: 0xffcce8cf),
      ), // 草绿
      "bright_yellow": NovelViewerPresetTheme(
        theme: NovelViewerTheme(foreground: 0xff333333, background: 0xffffffed),
      ), // 明黄
      "night_reading": NovelViewerPresetTheme(
        theme: NovelViewerTheme(foreground: 0xffe6edf3, background: 0xff0d1117),
      ), // 夜读
      "darker_light_gray": NovelViewerPresetTheme(
        theme: NovelViewerTheme(foreground: 0xffb8b8b8, background: 0xff1a1a1a),
      ), // 深浅灰
    };
  }
}
