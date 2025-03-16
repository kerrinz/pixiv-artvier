import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/component/filter/badge_with_remove_icon.dart';
import 'package:artvier/component/filter_dropdown/custom_dropdown.dart';
import 'package:artvier/component/sliver_persistent_header/tab_bar_delegate.dart';
import 'package:artvier/component/sliver_persistent_header/widget_delegate.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/ranking/provider/ranking_provider.dart';
import 'package:date_format/date_format.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/ranking/logic.dart';
import 'package:artvier/pages/ranking/ranking_tabpage.dart';
import 'package:artvier/config/ranking_mode_constants.dart';

/// 排行榜页面，集合了插画漫画小说
class RankingPage extends BaseStatefulPage {
  final WorksType worksType;

  const RankingPage(Object? arguments, {super.key}) : worksType = (arguments ?? WorksType.illust) as WorksType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RankingPageState();
}

class RankingPageState extends BasePageState<RankingPage> with TickerProviderStateMixin, RankingPageLogic {
  late final TabController _tabController;

  late final ScrollController _scrollController;

  @override
  CustomDropDownController dropDownController = CustomDropDownController();

  bool _hasMountedListener = false;

  @override
  ScrollController get scrollController => _scrollController;

  static final List<String> _illustTabs = [
    IllustRankingMode.daily,
    IllustRankingMode.weekly,
    IllustRankingMode.monthly,
    IllustRankingMode.dailyMale,
    IllustRankingMode.dailyFemale,
    IllustRankingMode.weeklyOriginal,
    IllustRankingMode.weeklyRookie,
    IllustRankingMode.dayAi,
    IllustRankingMode.dailyR18,
    IllustRankingMode.weeklyR18,
    IllustRankingMode.dailyR18Ai,
    IllustRankingMode.dailyMaleR18,
    IllustRankingMode.dailyFemaleR18,
  ];
  static final List<String> _mangaTabs = [
    MangaRankingMode.daily,
    MangaRankingMode.weekly,
    MangaRankingMode.monthly,
    MangaRankingMode.weeklyRookie,
    MangaRankingMode.dailyR18,
    MangaRankingMode.weeklyR18,
  ];

  static final List<String> _novelTabs = [
    NovelRankingMode.daily,
    NovelRankingMode.weekly,
    NovelRankingMode.dailyMale,
    NovelRankingMode.dailyFemale,
    NovelRankingMode.weeklyRookie,
    NovelRankingMode.weeklyAi,
    NovelRankingMode.dailyR18,
    NovelRankingMode.weeklyR18,
    NovelRankingMode.weeklyAiR18,
    NovelRankingMode.dailyMaleR18,
    NovelRankingMode.dailyFemaleR18,
  ];

  /// 候选列表
  List<WorksType> worksTypeSelectList = [
    WorksType.illust,
    WorksType.manga,
    WorksType.novel,
  ];

  late ValueNotifier<WorksType> worksType;

  @override
  DateTime datePickerValue = DateTime.now().subtract(const Duration(days: 1));

  get dayBeforeYesterday => DateTime.now().subtract(const Duration(days: 2));
  get yesterday => DateTime.now().subtract(const Duration(days: 1));

  @override
  void initState() {
    super.initState();
    worksType = ValueNotifier(widget.worksType);
    worksType.addListener(() {
      updateTabControllers(worksType.value);
    });
    updateTabControllers(widget.worksType);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasMountedListener) {
      _scrollController = PrimaryScrollController.of(context);
      _hasMountedListener = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            leading: const AppbarLeadingButtton(),
            title: ValueListenableBuilder<WorksType>(
              valueListenable: worksType,
              builder: (BuildContext context, value, Widget? child) {
                if (value == WorksType.illust) {
                  return Text(l10n.illustRankings);
                } else if (value == WorksType.manga) {
                  return Text(l10n.mangaRankings);
                } else {
                  return Text(l10n.novelRankings);
                }
              },
            ),
            toolbarHeight: Theme.of(context).appBarTheme.toolbarHeight ?? kToolbarHeight,
            actions: [
              IconButton(
                icon: const Icon(Icons.calendar_month_outlined),
                onPressed: handlePressedDatePicker,
                tooltip: l10n.selectDate,
              ),
            ],
          ),
          // DatePicker
          CustomDropDownOverlay(
            controller: dropDownController,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                color: colorScheme.surface,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      use24hFormat: true,
                      initialDateTime: ref.watch(rankingDateProvier) ?? yesterday,
                      minimumDate: DateTime(2012, 9, 10),
                      maximumDate: yesterday,
                      onDateTimeChanged: (DateTime newDateTime) => datePickerValue = newDateTime,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: BlurButton(
                            padding: EdgeInsets.zero,
                            background: Colors.transparent,
                            onPressed: handlePressedDateReset,
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.1),
                                border: Border.all(color: colorScheme.primary.withAlpha(100)),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(l10n.promptReset,
                                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.primary)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: BlurButton(
                            padding: EdgeInsets.zero,
                            background: Colors.transparent,
                            onPressed: handlePressedDateConfirm,
                            child: Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Center(
                                child: Text(
                                  l10n.promptConform,
                                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onPrimary),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Tabs
          Container(
            width: double.infinity,
            height: kTabBarHeight,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
            color: colorScheme.surface,
            child: ValueListenableBuilder<WorksType>(
              valueListenable: worksType,
              builder: (BuildContext context, value, Widget? child) {
                if (value == WorksType.illust) {
                  return TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    tabs: [
                      for (String tab in _illustTabs) Tab(text: getTabName(value, tab)),
                    ],
                  );
                } else if (value == WorksType.manga) {
                  return TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    tabs: [
                      for (String tab in _mangaTabs) Tab(text: getTabName(value, tab)),
                    ],
                  );
                } else {
                  return TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    padding: EdgeInsets.zero,
                    tabs: [
                      for (String tab in _novelTabs) Tab(text: getTabName(value, tab)),
                    ],
                  );
                }
              },
            ),
          ),
          // Tab content
          Expanded(
            child: ExtendedNestedScrollView(
              floatHeaderSlivers: true,
              onlyOneScrollInBody: true,
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                final dateTime = ref.watch(rankingDateProvier);
                if (dateTime == null) return [];
                return [
                  SliverPersistentHeader(
                    floating: true,
                    delegate: SliverWidgetPersistentHeaderDelegate(
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              BadgeWithRemoveIcon(
                                color: colorScheme.primary,
                                onTapIcon: handleRemoveDate,
                                child: Text(
                                  formatDate(dateTime, [yyyy, '-', mm, '-', dd]),
                                  style: textTheme.bodySmall?.copyWith(color: colorScheme.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      maxHeight: 36,
                      minHeight: 36,
                    ),
                  ),
                ];
              },
              body: ValueListenableBuilder<WorksType>(
                valueListenable: worksType,
                builder: (BuildContext context, value, Widget? child) {
                  if (value == WorksType.illust) {
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        for (int i = 0; i < _illustTabs.length; i++)
                          RankingIllustTabPage(
                            mode: _illustTabs[i],
                            controller: _tabController,
                            index: i,
                          ),
                      ],
                    );
                  } else if (value == WorksType.manga) {
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        for (int i = 0; i < _mangaTabs.length; i++)
                          RankingMangaTabPage(
                            mode: _mangaTabs[i],
                            controller: _tabController,
                            index: i,
                          ),
                      ],
                    );
                  } else {
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        for (int i = 0; i < _novelTabs.length; i++)
                          RankingNovelTabPage(
                            mode: _novelTabs[i],
                            controller: _tabController,
                            index: i,
                          ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateTabControllers(WorksType worksType) {
    if (worksType == WorksType.illust) {
      _tabController = TabController(initialIndex: 0, length: _illustTabs.length, vsync: this);
    } else if (widget.worksType == WorksType.manga) {
      _tabController = TabController(initialIndex: 0, length: _mangaTabs.length, vsync: this);
    } else {
      _tabController = TabController(initialIndex: 0, length: _novelTabs.length, vsync: this);
    }
  }

  /// 获取Tab对应的名称
  String? getTabName(WorksType worksType, String rankingMode) {
    if (worksType == WorksType.illust) {
      // 插画分页
      Map<String, String> tabMap = {
        IllustRankingMode.daily: l10n.rankingDaily,
        IllustRankingMode.weekly: l10n.rankingWeekly,
        IllustRankingMode.monthly: l10n.rankingMonthly,
        IllustRankingMode.dailyMale: l10n.rankingMale,
        IllustRankingMode.dailyFemale: l10n.rankingFemale,
        IllustRankingMode.weeklyOriginal: l10n.rankingOriginal,
        IllustRankingMode.weeklyRookie: l10n.rankingRookie,
        IllustRankingMode.dayAi: l10n.rankingAiGenerated,
        IllustRankingMode.dailyR18: l10n.rankingR18Daily,
        IllustRankingMode.weeklyR18: l10n.rankingR18Weekly,
        IllustRankingMode.dailyR18Ai: l10n.rankingR18AiGenerated,
        IllustRankingMode.dailyMaleR18: l10n.rankingR18Male,
        IllustRankingMode.dailyFemaleR18: l10n.rankingR18Female,
      };
      return tabMap[rankingMode];
    } else if (worksType == WorksType.manga) {
      // 漫画分页
      Map<String, String> tabMap = {
        MangaRankingMode.daily: l10n.rankingDaily,
        MangaRankingMode.weekly: l10n.rankingWeekly,
        MangaRankingMode.monthly: l10n.rankingMonthly,
        MangaRankingMode.weeklyRookie: l10n.rankingRookie,
        MangaRankingMode.dailyR18: l10n.rankingR18Daily,
        MangaRankingMode.weeklyR18: l10n.rankingR18Weekly,
      };
      return tabMap[rankingMode];
    } else {
      // 小说分页
      Map<String, String> tabMap = {
        NovelRankingMode.daily: l10n.rankingDaily,
        NovelRankingMode.weekly: l10n.rankingWeekly,
        NovelRankingMode.dailyMale: l10n.rankingMale,
        NovelRankingMode.dailyFemale: l10n.rankingFemale,
        NovelRankingMode.weeklyRookie: l10n.rankingRookie,
        NovelRankingMode.weeklyAi: l10n.rankingAiGenerated,
        NovelRankingMode.dailyR18: l10n.rankingR18Daily,
        NovelRankingMode.weeklyR18: l10n.rankingR18Weekly,
        NovelRankingMode.weeklyAiR18: l10n.rankingR18AiGenerated,
        NovelRankingMode.dailyMaleR18: l10n.rankingR18Male,
        NovelRankingMode.dailyFemaleR18: l10n.rankingR18Female,
      };
      return tabMap[rankingMode];
    }
  }

  @override
  void dispose() {
    if (_scrollController.hasClients) {
      _scrollController.dispose();
    }
    super.dispose();
  }
}
