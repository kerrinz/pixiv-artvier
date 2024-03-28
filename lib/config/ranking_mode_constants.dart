/// 排行榜的模式
///
/// 插画排行模式
class IllustRankingMode {
  static const String daily = "day";
  static const String dailyMale = "day_male";
  static const String dailyFemale = "day_female";
  static const String weekly = "week";
  /// 原创榜
  static const String weeklyOriginal = "week_original";
  /// 新人榜
  static const String weeklyRookie = "week_rookie";
  static const String monthly = "month";
  /// 必须指定日期
  static const String dailyR18 = "day_r18";
  /// 必须指定日期
  static const String weeklyR18 = "week_r18";
  /// 必须指定日期
  static const String dailyMaleR18 = "day_male_r18";
  /// 必须指定日期
  static const String dailyFemaleR18 = "day_female_r18";
}

/// 漫画排行模式
class MangaRankingMode {
  static const String daily = "day_manga";
  static const String weekly = "week_manga";
  static const String weeklyRookie = "week_rookie_manga";
  static const String monthly = "month_manga";
  /// 必须指定日期
  static String get dailyR18 => IllustRankingMode.dailyR18;
  /// 必须指定日期
  static String get weeklyR18 => IllustRankingMode.dailyR18;
  /// 必须指定日期
  static String get dailyMaleR18 => IllustRankingMode.dailyR18;
  /// 必须指定日期
  static String get dailyFemaleR18 => IllustRankingMode.dailyR18;
}

/// 小说排行模式
class NovelRankingMode {
  static get daily =>IllustRankingMode.dailyR18;
  static get dailyMale => IllustRankingMode.dailyMale;
  static get dailyFemale => IllustRankingMode.dailyFemale;
  static get weekly => IllustRankingMode.weekly;
  /// 新人榜
  static get weeklyRookie => IllustRankingMode.weeklyRookie;
  static get monthly => IllustRankingMode.monthly;
  /// 必须指定日期
  static String get dailyR18 => IllustRankingMode.dailyR18;
  /// 必须指定日期
  static String get weeklyR18 => IllustRankingMode.dailyR18;
  /// 必须指定日期
  static String get dailyMaleR18 => IllustRankingMode.dailyR18;
  /// 必须指定日期
  static String get dailyFemaleR18 => IllustRankingMode.dailyR18;
}
