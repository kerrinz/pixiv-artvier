import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/business_component/listview/user_vertical_listview/logic.dart';
import 'package:artvier/component/image/enhance_network_image.dart';
import 'package:artvier/config/enums.dart';
import 'package:artvier/model_response/illusts/common_illust.dart';
import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:artvier/model_response/user/common_user_previews.dart';
import 'package:artvier/model_response/user/preload_user_least_info.dart';
import 'package:artvier/routes.dart';

class UserVerticalListViewItem extends ConsumerStatefulWidget {
  const UserVerticalListViewItem({
    super.key,
    required this.user,
    required this.followState,
    required this.onTap,
  });

  final CommonUserPreviews user;

  /// 关注状态
  final UserFollowState followState;

  /// 点击卡片的事件
  final VoidCallback onTap;

  /// 用户最近发布的作品的图片（小说封面也包含在内）
  static List<String> recentPublishWorksImagesUrls(List<CommonIllust> illusts, List<CommonNovel> novels,
      {int max = 3}) {
    List<String> urls = [];
    // 添加插画·漫画
    for (int i = 0; i < illusts.length; i++) {
      if (urls.length < max) {
        urls.add(illusts[i].imageUrls.squareMedium);
      } else {
        break;
      }
    }
    // 添加小说
    for (int i = 0; i < novels.length; i++) {
      if (urls.length < max) {
        urls.add(novels[i].imageUrls.medium);
      } else {
        break;
      }
    }
    return urls;
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserVerticalListViewItemState();
}

class _UserVerticalListViewItemState extends ConsumerState<UserVerticalListViewItem>
    with UserVerticalListViewItemLogic {
  @override
  UserFollowState get followState => widget.followState;

  @override
  String get userId => userData.user.id.toString();

  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  CommonUserPreviews get userData => widget.user;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        var imgWidth = constraints.maxWidth / 3; // 单个图片的宽度
        return Container(
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // 图片与用户名
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: imgWidth,
                    child: Row(
                      children: _imageWidgets(context),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 80.0, top: 12, bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userData.user.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              // 图片的遮罩层
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: imgWidth,
                child: Container(
                  color: Colors.black26,
                ),
              ),
              // 用户头像
              Positioned(
                bottom: 4,
                left: 4,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: const BorderRadius.all(Radius.circular(80)),
                      ),
                      child: ClipOval(
                        child: EnhanceNetworkImage(
                          image: ExtendedNetworkImageProvider(
                            HttpHostOverrides().pxImgUrl(userData.user.profileImageUrls.medium),
                            headers: HttpHostOverrides().pximgHeaders,
                            cache: true,
                          ),
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 触控效果层
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.black12.withOpacity(0.15),
                    highlightColor: Colors.black12.withOpacity(0.1),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteNames.userDetail.name,
                          arguments: PreloadUserLeastInfo(
                              userData.user.id.toString(), userData.user.name, userData.user.profileImageUrls.medium));
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 图片（作品）列表
  List<Widget> _imageWidgets(context) {
    List<Widget> widgets = [];
    widgets.addAll([
      for (String url in UserVerticalListViewItem.recentPublishWorksImagesUrls(userData.illusts, userData.novels))
        _imageWidget(url),
    ]);
    while (widgets.length < 3) {
      widgets.add(DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      ));
    }
    return widgets;
  }

  // 构建图片
  Widget _imageWidget(String url) {
    return EnhanceNetworkImage(
      image: ExtendedNetworkImageProvider(
        HttpHostOverrides().pxImgUrl(url),
        headers: HttpHostOverrides().pximgHeaders,
        cache: true,
      ),
    );
  }
}
