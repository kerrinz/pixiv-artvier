import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/widgets/illust_waterfall_gird.dart';
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
    IllustGirdTabPage(
      onRefresh: () async {
        return await ApiNewArtWork().getFollowsNewIllusts(ApiNewArtWork.restrict_all);
      },
      onLazyLoad: (String nextUrl) async {
        var result = await ApiBase().getNextUrlData(nextUrl: nextUrl);
        return CommonIllustList.fromJson(result);
      },
    ),
 */
class IllustGirdTabPage extends StatefulWidget {
  IllustLazyLoadCallback onLazyLoad; // 懒加载
  IllustRefreshCallback onRefresh; // 刷新（包含首次加载）
  Widget? withoutIllustWidget; // 列表为空时的展示组件
  ScrollController? scrollController; // 滚动控制器
  ScrollPhysics? physics; // 滚动物理效果

  State<StatefulWidget> createState() => IllustGirdTabPageState();

  IllustGirdTabPage({
    Key? key,
    required this.onLazyLoad,
    required this.onRefresh,
    this.withoutIllustWidget,
    this.scrollController,
    this.physics,
  }) : super(key: key);
}

class IllustGirdTabPageState extends State<IllustGirdTabPage> with AutomaticKeepAliveClientMixin {
  IllustGirdPageProvider _provider = IllustGirdPageProvider();

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
          builder: (context, IllustGirdPageProvider provider, Widget? child) {
            if (provider.illustList?.length == 0) {
              // 列表为空时展示
              return SingleChildScrollView(
                physics: widget.physics,
                child: widget.withoutIllustWidget ??
                    // 默认展示的样式
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      alignment: Alignment.center,
                      child: Text("暂无", style: TextStyle(fontSize: 18)),
                    ),
              );
            }
            return IllustWaterfallGird(
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class IllustGirdPageProvider with ChangeNotifier {
  List<CommonIllust>? illustList; // 插画（或漫画）列表
  String? nextUrl;

  setAll(List<CommonIllust>? newIllustList, String? nextUrl) {
    this.illustList = newIllustList;
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  setIllustList(List<CommonIllust>? newIllustList) {
    this.illustList = newIllustList;
    notifyListeners();
  }

  addIllustList(List<CommonIllust> moreIllustList) {
    this.illustList = [...illustList ?? [], ...moreIllustList];
    notifyListeners();
  }

  setNextUrl(String? nextUrl) {
    this.nextUrl = nextUrl;
    notifyListeners();
  }
}
