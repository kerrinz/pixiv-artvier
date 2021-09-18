import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/illusts/common_illust_list.dart';
import 'package:pixgem/request/api_user.dart';
import 'package:pixgem/store/global.dart';
import 'package:pixgem/widgets/illust_waterfall_gird_sliver.dart';
import 'package:provider/provider.dart';

class MyIllustsBookmarkPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyIllustsBookmarkState();
  }

}

class _MyIllustsBookmarkState extends State<MyIllustsBookmarkPage> {
  _ListProvider _provider = _ListProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('我的插画收藏'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 1,
            child: ChangeNotifierProvider(
              create: (BuildContext context) => _provider,
              child: RefreshIndicator(
                // 下拉刷新
                onRefresh: () async {
                  await refreshAndSetData().then((value) {
                    Fluttertoast.showToast(msg: "刷新成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                  }).catchError((onError) {
                    Fluttertoast.showToast(msg: "Error！刷新失败", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                    print(onError);
                  });
                },
                child: Selector(
                  builder: (BuildContext context, List<CommonIllust> illusts, Widget? child) {
                    return IllustWaterfallGirdSliver(
                      // 普通网格布局（图片）
                      artworkList: illusts,
                      limit: 1000,
                      onLazyLoad: () {
                        requestMoreBookmarks().catchError((onError) {
                          Fluttertoast.showToast(
                              msg: "Error！获取更多作品失败", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                          print(onError);
                        });
                      },
                    );
                  },
                  selector: (context, _ListProvider provider) {
                    return provider.illustList;
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  refreshAndSetData() async {
    CommonIllustList bookmarks = await ApiUser().getUserBookmarksIllust(userId: GlobalStore.currentAccount!.user.id);
    _provider.setBookmarksList(list: bookmarks.illusts); // [重置]收藏list
    _provider.setPage(page: 1); // 页码[重置]为1
  }

  requestMoreBookmarks() async {
    CommonIllustList bookmarks = await ApiUser().getUserBookmarksIllust(userId: GlobalStore.currentAccount!.user.id);
    _provider.addAllBookmarks(list: bookmarks.illusts); // [重置]收藏list
    _provider.pageAdd(); // 页码 + 1
  }

  @override
  void initState() {
    super.initState();
    refreshAndSetData();
  }
}

class _ListProvider with ChangeNotifier {
  List<CommonIllust> illustList = []; // UI展示的收藏列表
  int page = 0; // 页码

  void setPage({required page}) {
    this.page = page;
    notifyListeners();
  }

  void pageAdd() {
    page++;
    notifyListeners();
  }

  void setBookmarksList({required List<CommonIllust> list}) {
    illustList = list;
    notifyListeners();
  }

  void addAllBookmarks({required List<CommonIllust> list}) {
    illustList = [...illustList, ...list];
    notifyListeners();
  }

  void clearBookmarks() {
    illustList.clear();
    notifyListeners();
  }
}