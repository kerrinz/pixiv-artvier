/// 排行榜的模式
/// */

class RankingModeConstants {
  // 插画，以下几个《可选择》指定日期 &date=2021-07-11
  static const String illust_day = "day";
  static const String illust_day_male = "day_male";
  static const String illust_day_female = "day_female";
  static const String illust_week = "week";
  static const String illust_week_original = "week_original";
  static const String illust_week_rookie = "week_rookie";
  static const String illust_month = "month";
  // 插画，以下几个《必需》指定日期
  static const String illust_day_r18 = "day_r18";
  static const String illust_week_r18 = "week_r18";
  static const String illust_day_male_r18 = "day_male_r18";
  static const String illust_day_female_r18 = "day_female_r18";

  // 漫画，都可指定日期；额外还有 R18每日、R18每周，与插画的完全一致
  static const String manga_day = "day_manga";
  static const String manga_week_rookie = "week_rookie_manga";
  static const String manga_week = "week_manga";
  static const String manga_month = "month_manga";
}