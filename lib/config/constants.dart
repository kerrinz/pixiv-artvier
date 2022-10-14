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
  static const String referer_artworks_base = "https://www.pixiv.net/artworks/";
  static const String stamp_url_base = "https://s.pximg.net/common/images/stamp/generated-stamps/"; // 用于表情图片的显示
  static const String pixiv_host_url = "https://www.pixiv.net";
  static const String pixiv_account_url = "https://accounts.pixiv.net";

  static const String proxy_default_host = "127.0.0.1";
  static const String proxy_default_port = "1080";
}
