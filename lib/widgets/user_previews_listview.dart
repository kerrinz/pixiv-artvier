import 'package:flutter/material.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';
import 'package:pixgem/model_response/user/user_previews_list.dart';
import 'package:pixgem/widgets/user_previews_card.dart';
import 'package:provider/provider.dart';

typedef RefreshCallback = Future<UserPreviewsList> Function();
typedef LazyLoadCallback = Future<UserPreviewsList> Function(String nextUrl);

class UsersCardListView extends StatefulWidget {
  final LazyLoadCallback onLazyLoad; // 懒加载，会传入nextUrl
  final RefreshCallback onRefresh; // 刷新（包含首次加载）
  final int? limit; // 列表项的极限数量，为空则表示不限

  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  UsersCardListView(
      {Key? key, required this.onLazyLoad, required this.onRefresh, this.limit, this.scrollController, this.physics})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => UsersCardListViewState();
}

class UsersCardListViewState extends State<UsersCardListView> {
  UserPreviewsListViewProvider _provider = UserPreviewsListViewProvider();

  @override
  void initState() {
    super.initState();
    widget.onRefresh().then((value) => _provider.setAll(value.userPreviews, value.nextUrl));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: RefreshIndicator(
        onRefresh: () async {
          var result = await widget.onRefresh();
          _provider.setAll(result.userPreviews, result.nextUrl);
        },
        child: Consumer(
          builder: (BuildContext context, UserPreviewsListViewProvider provider, Widget? child) {
            if (provider.userList == null) {
              return _buildLoading(context);
            }
            return ListView.builder(
              physics: widget.physics,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                var list = provider.userList!;
                // 如果滑动到了表尾
                if (index == list.length - 1) {
                  // 未到列表上限，继续获取数据
                  if (provider.nextUrl != null) {
                    if (list.length > 0)
                      widget.onLazyLoad(provider.nextUrl!).then((value) {
                        _provider.addIllustList(value.userPreviews);
                        _provider.setNextUrl(value.nextUrl);
                      }); // 列表不为空才获取数据
                    //加载时显示loading
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: _buildLoading(context),
                    );
                  } else {
                    // 达到上限，不再获取
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "没有更多了",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: UserPreviewsCard(
                    user: provider.userList![index],
                    type: UserPreviewsType.illust,
                  ),
                );
              },
              itemCount: provider.userList?.length ?? 0,
            );
          },
        ),
      ),
    );
  }

  // 构建循环加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeWidth: 1.0),
    );
  }
}

class UserPreviewsListViewProvider with ChangeNotifier {
  List<CommonUserPreviews>? userList; // 用户列表
  String? nextUrl;

  setAll(List<CommonUserPreviews>? newUserList, String? nextUrl) {
    this.userList = newUserList;
    this.nextUrl = nextUrl;
    notifyListeners();
  }

  setIllustList(List<CommonUserPreviews>? newUserList) {
    this.userList = newUserList;
    notifyListeners();
  }

  addIllustList(List<CommonUserPreviews> moreUserList) {
    this.userList = [...userList ?? [], ...moreUserList];
    notifyListeners();
  }

  setNextUrl(String? nextUrl) {
    this.nextUrl = nextUrl;
    notifyListeners();
  }
}
