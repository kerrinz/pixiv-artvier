/// 排行榜的模式
///
/// 插画排行模式
class IllustRankingMode {
  static const String daily = "day";
  static const String dailyMale = "day_male";
  static const String dailyFemale = "day_female";
  static const String dayAi = "day_ai";
  static const String weekly = "week";

  /// 原创榜
  static const String weeklyOriginal = "week_original";

  /// 新人榜
  static const String weeklyRookie = "week_rookie";
  static const String monthly = "month";
  // 以下必须指定日期
  static const String dailyR18 = "day_r18";
  static const String dailyR18Ai = "day_r18_ai";
  static const String dailyMaleR18 = "day_male_r18";
  static const String dailyFemaleR18 = "day_female_r18";
  static const String weeklyR18 = "week_r18";
}

/// 漫画排行模式
class MangaRankingMode {
  static const String daily = "day_manga";
  static const String weekly = "week_manga";
  static const String weeklyRookie = "week_rookie_manga";
  static const String monthly = "month_manga";

  static const String dailyR18 = "day_r18_manga";
  static const String weeklyR18 = "week_r18_manga";
}

/// 小说排行模式
class NovelRankingMode {
  static String get daily => IllustRankingMode.daily;
  static String get dailyMale => IllustRankingMode.dailyMale;
  static String get dailyFemale => IllustRankingMode.dailyFemale;
  static String get weekly => IllustRankingMode.weekly;
  static String get weeklyAi => "week_ai";
  static String get weeklyRookie => IllustRankingMode.weeklyRookie;

  static String get dailyR18 => IllustRankingMode.dailyR18;
  static String get weeklyR18 => IllustRankingMode.weeklyR18;
  static String get dailyMaleR18 => IllustRankingMode.dailyMaleR18;
  static String get dailyFemaleR18 => IllustRankingMode.dailyFemaleR18;
  static String get weeklyAiR18 => "week_ai_r18";
}
