// ignore_for_file: constant_identifier_names

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
  static const Map<String, String> stickerMap = {
    "101_s": "normal",
    "102_s": "surprise",
    "103_s": "serious",
    "201_s": "normal2",
    "202_s": "shame2",
    "203_s": "love2",
    "204_s": "interesting2",
    "205_s": "blush2",
    "206_s": "fire2",
    "207_s": "angry2",
    "208_s": "shine2",
    "209_s": "panic2",
    "210_s": "panic2",
    "301_s": "normal3",
    "302_s": "satisfaction3",
    "303_s": "surprise3",
    "304_s": "smile3",
    "305_s": "shock3",
    "306_s": "gaze3",
    "307_s": "wink3",
    "308_s": "happy3",
    "309_s": "excited3",
    "310_s": "love3",
    "401_s": "normal4",
    "402_s": "surprise4",
    "403_s": "serious4",
    "404_s": "love4",
    "405_s": "shine4",
    "406_s": "sweat4",
    "407_s": "shame4",
    "408_s": "sleep4",
    "409_s": "sleep4",
    "410_s": "sleep4",
    "601_s": "heart",
    "602_s": "teardrop",
    "603_s": "star",
    "604_s": "star",
    "605_s": "star",
    "606_s": "star",
    "607_s": "star",
    "608_s": "star",
    "609_s": "star",
    "610_s": "star",
    "701_s": "star",
    "702_s": "star",
    "703_s": "star",
    "704_s": "star",
    "705_s": "star",
    "706_s": "star",
    "707_s": "star",
    "708_s": "star",
    "709_s": "star",
    "710_s": "star",
  };
}
