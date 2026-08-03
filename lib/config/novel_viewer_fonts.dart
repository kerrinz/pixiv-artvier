/// 小说阅读器可选字体（Google Fonts 预设，仅需字体族名）
class NovelViewerFontOption {
  const NovelViewerFontOption({
    required this.name,
    this.fontFamily,
  });

  /// 展示名称
  final String name;

  /// Google Fonts 字体族名（[GoogleFonts.getFont] 的参数）；null 表示 App 默认字体
  final String? fontFamily;
}

/// 小说阅读可用字体预设
List<NovelViewerFontOption> novelViewerFontOptions() => const [
      NovelViewerFontOption(name: '默认'),
      // 中文
      NovelViewerFontOption(name: '思源黑体', fontFamily: 'Noto Sans SC'),
      NovelViewerFontOption(name: '思源宋体', fontFamily: 'Noto Serif SC'),
      // 日文
      NovelViewerFontOption(name: 'Noto Sans JP', fontFamily: 'Noto Sans JP'),
      NovelViewerFontOption(name: 'Noto Serif JP', fontFamily: 'Noto Serif JP'),
      NovelViewerFontOption(name: 'Zen丸ゴシック', fontFamily: 'Zen Maru Gothic'),
      NovelViewerFontOption(name: 'Zen旧明朝', fontFamily: 'Zen Old Mincho'),
      NovelViewerFontOption(name: 'しっぽり明朝', fontFamily: 'Shippori Mincho'),
      NovelViewerFontOption(name: 'さわらび明朝', fontFamily: 'Sawarabi Mincho'),
      NovelViewerFontOption(name: '小杉丸', fontFamily: 'Kosugi Maru'),
      NovelViewerFontOption(name: 'キウイ丸', fontFamily: 'Kiwi Maru'),
      NovelViewerFontOption(name: 'ひな明朝', fontFamily: 'Hina Mincho'),
      NovelViewerFontOption(name: 'ニューテゴミン', fontFamily: 'New Tegomin'),
      NovelViewerFontOption(name: 'ドットゴシック', fontFamily: 'DotGothic16'),
      NovelViewerFontOption(name: '柚子行書', fontFamily: 'Yuji Syuku'),
      // 圆体 / 趣味
      NovelViewerFontOption(name: 'M PLUS Rounded', fontFamily: 'M PLUS Rounded 1c'),
    ];
