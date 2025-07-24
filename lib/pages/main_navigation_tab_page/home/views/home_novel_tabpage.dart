import 'dart:math';

import 'package:artvier/business_component/listview/novel_listview/novel_list.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/global/model/account_profile/account_profile.dart';
import 'package:artvier/global/model/collect_state_changed_arguments/collect_state_changed_arguments.dart';
import 'package:artvier/global/provider/collection_state_provider.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/provider/home_novel_provider.dart';
import 'package:artvier/pages/novel/detail/arguments/novel_detail_page_args.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/base/base_page.dart';
import 'package:artvier/component/loading/request_loading.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/pages/main_navigation_tab_page/home/provider/home_provider.dart';
import 'package:artvier/routes.dart';

class HomeNovelTabPage extends BaseStatefulPage {
  final ScrollController? scrollController;

  const HomeNovelTabPage({super.key, this.scrollController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomeNovelTabPageState();
}

class HomeNovelTabPageState extends BasePageState<HomeNovelTabPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int size = 20;

  bool keepAlive = true;

  @override
  bool get wantKeepAlive => keepAlive;

  /// 首页漫画的加载状态
  final homeNovelStateProvider = StateNotifierProvider<HomeNovelStateNotifier, PageState>((ref) {
    // // 监听全局收藏状态的变化，更新列表
    ref.listen<CollectStateChangedArguments?>(globalNovelCollectionStateChangedProvider, (previous, next) {
      if (next != null) {
        var list = ref.read(homeNovelRecommendedProvider);
        int index = list.lastIndexWhere((element) => element.id.toString() == next.worksId);
        if (index >= 0 && index < list.length) {
          var newItem = list[index]
            ..isBookmarked = next.state == CollectState.collected
            ..collectState = next.state;
          ref.read(homeNovelRecommendedProvider.notifier).update(list..[index] = newItem);
        }
      }
    });
    return HomeNovelStateNotifier(PageState.loading, ref: ref)..init();
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ref.listen<AccountProfile?>(globalCurrentAccountProvider, (previous, next) {
      keepAlive = false;
      updateKeepAlive();
    });
    return RefreshIndicator(
      onRefresh: () async => ref.read(homeNovelStateProvider.notifier).refresh(),
      child: Consumer(builder: (_, ref, __) {
        PageState pageState = ref.watch(homeNovelStateProvider);
        if (pageState != PageState.complete && pageState != PageState.refreshing && pageState != PageState.empty) {
          return Center(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              child: Builder(
                builder: (context) {
                  switch (pageState) {
                    case PageState.loading:
                      return const RequestLoading();
                    default:
                      return RequestLoadingFailed(
                          onRetry: () async => ref.read(homeNovelStateProvider.notifier).init());
                  }
                },
              ),
            ),
          );
        }
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: widget.scrollController,
          slivers: [
            // 排行榜头部
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 12, top: MediaQuery.of(context).padding.top + kToolbarHeight),
                child: Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.leaderboard_rounded,
                            color: Colors.amber,
                            size: 24,
                          ),
                          Text(
                            " ${l10n.novelRankings}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteNames.ranking.name, arguments: WorksType.novel);
                      },
                      // style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(l10n.more),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 排行榜卡片列表
            Consumer(
              builder: (context, ref, child) {
                var data = ref.watch(homeNovelRankingProvider);
                return buildRankingCardList(ref.context, data);
              },
            ),
            // 推荐头部
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 12, top: 16, bottom: 8),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.favorite_rounded,
                            color: Colors.deepOrange,
                            size: 24,
                          ),
                          Text(
                            " ${l10n.recommended}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 推荐列表
            Consumer(
              builder: (context, ref, child) {
                var data = ref.watch(homeNovelRecommendedProvider);
                return SliverNovelListView(
                  novelList: data,
                  onLazyload: ref.read(homeIllustRecommendedProvider.notifier).next,
                );
              },
            ),
          ],
        );
      }),
    );
  }

  // 构建排行榜卡片列表（横向
  Widget buildRankingCardList(BuildContext context, List<CommonNovel> rankingList) {
    double width = min(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height) / 2.5;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: width * 1.3,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 8, right: 8),
          itemBuilder: (context, index) {
            return SizedBox(
              width: width,
              height: width * 1.3,
              child: Card(
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                color: colorScheme.surface,
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    EnhanceNetworkImage(
                      width: double.infinity,
                      height: double.infinity,
                      image: ExtendedNetworkImageProvider(
                        HttpHostOverrides().pxImgUrl(rankingList[index].imageUrls.medium),
                        headers: HttpHostOverrides().pximgHeaders,
                      ),
                    ),
                    // 阴影
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: width / 1.5,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0x00000000),
                            Color.fromARGB(75, 0, 0, 0),
                            Color.fromARGB(200, 0, 0, 0),
                          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                        ),
                      ),
                    ),
                    // 描述信息
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 作品标题
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                rankingList[index].title,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // 作者头像
                                ClipOval(
                                  child: EnhanceNetworkImage(
                                    image: ExtendedNetworkImageProvider(
                                      HttpHostOverrides().pxImgUrl(rankingList[index].user.profileImageUrls.medium),
                                      headers: HttpHostOverrides().pximgHeaders,
                                    ),
                                    fit: BoxFit.cover,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    rankingList[index].user.name,
                                    style:
                                        const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black12.withValues(alpha: 0.15),
                          highlightColor: Colors.black12.withValues(alpha: 0.1),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              RouteNames.novelDetail.name,
                              arguments: NovelDetailPageArguments(
                                novelId: rankingList[index].id.toString(),
                                detail: rankingList[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: rankingList.length,
        ),
      ),
    );
  }
}
