import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/widgets/illust_waterfall_grid.dart';
import 'package:provider/provider.dart';

typedef IllustRefreshCallback = Future<CommonIllustList> Function();
typedef IllustLazyLoadCallback = Future<CommonIllustList> Function(String nextUrl);

/* 适用于放在TabView里的插画列表页面
 * @parma
 *    scrollController
 * @required parma
 *    onLazyLoad(String nextUrl)
 *    onRefresh()
 *
 * For example:
    IllustGridTabPage(
      onRefresh: () async {
        return await ApiNewArtWork().getFollowsNewIllusts(ApiNewArtWork.restrict_all);
      },
      onLazyLoad: (String nextUrl) async {
        var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
        return CommonIllustList.fromJson(result);
      },
    ),
 */
class IllustGridTabPage extends StatefulWidget {
  final IllustLazyLoadCallback onLazyLoad; // 懒加载
  final IllustRefreshCallback onRefresh; // 刷新（包含首次加载）
  final Widget? withoutIllustWidget; // 列表为空时的展示组件
  final ScrollController? scrollController; // 滚动控制器
  final ScrollPhysics? physics; // 滚动物理效果

  @override
  State<StatefulWidget> createState() => IllustGridTabPageState();

  const IllustGridTabPage({
    Key? key,
    required this.onLazyLoad,
    required this.onRefresh,
    this.withoutIllustWidget,
    this.scrollController,
    this.physics,
  }) : super(key: key);
}

class IllustGridTabPageState extends State<IllustGridTabPage> with AutomaticKeepAliveClientMixin {
  final IllustGridPageProvider _provider = IllustGridPageProvider();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: RefreshIndicator(
        onRefresh: () async {
          var result = await widget.onRefresh();
          _provider.setAll(result.illusts, result.nextUrl);
        },
        child: Consumer(
          builder: (context, IllustGridPageProvider provider, Widget? child) {
            if (provider.illustList?.isEmpty ?? false) {
              // 列表为空时展示
              return SingleChildScrollView(
                physics: widget.physics,
                child: widget.withoutIllustWidget ??
                    // 默认展示的样式
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      alignment: Alignment.center,
                      child: const Text("暂无", style: TextStyle(fontSize: 18)),
                    ),
              );
            }
            return IllustWaterfallGrid(
              physics: widget.physics,
              artworkList: provider.illustList ?? [],
              onLazyLoad: () async {
                if (provider.nextUrl == null) {
                  return Fluttertoast.showToast(msg: "已经加载到底了", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                }
                var moreIllustList = await widget.onLazyLoad(provider.nextUrl!); // 懒加载传入下一页地址
                provider.addIllustList(moreIllustList.illusts);
              },
              scrollController: widget.scrollController,
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.onRefresh().then((value) => _provider.setAll(value.illusts, value.nextUrl));
  }

  @override
  bool get wantKeepAlive => true;
}

class IllustGridPageProvider with ChangeNotifier {
  List<CommonIllust>? illustList; // 插画（或漫画）列表
  String? nextUrl;

  setAll(List<CommonIllust>? newIllustList, String? nextUrl) {
    illustList = newIllustList;
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  setIllustList(List<CommonIllust>? newIllustList) {
    illustList = newIllustList;
    notifyListeners();
  }

  addIllustList(List<CommonIllust> moreIllustList) {
    illustList = [...illustList ?? [], ...moreIllustList];
    notifyListeners();
  }

  setNextUrl(String? nextUrl) {
    this.nextUrl = nextUrl;
    notifyListeners();
  }
}
