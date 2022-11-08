import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/component/image/enhance_network_image.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/model_response/novels/common_novel.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';
import 'package:pixgem/routes.dart';

class UserVerticalListItem extends StatelessWidget {
  final CommonUserPreviews user;

  const UserVerticalListItem({Key? key, required this.user}) : super(key: key);

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
                      children: _buildImages(context),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 80.0, top: 12, bottom: 12),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      user.user.name,
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
                            user.user.profileImageUrls.medium,
                            headers: const {"referer": CONSTANTS.referer},
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
                          arguments:
                              PreloadUserLeastInfo(user.user.id, user.user.name, user.user.profileImageUrls.medium));
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

  /// 构建图片
  List<Widget> _buildImages(context) {
    List<Widget> widgets = [];
    // 添加插画·漫画
    for (int i = 0; i < user.illusts.length; i++) {
      if (widgets.length < 3) {
        widgets.add(_buildArtworkImage(user.illusts[i]));
      } else {
        break;
      }
    }
    // 添加小说
    for (int i = 0; i < user.novels.length; i++) {
      if (widgets.length < 3) {
        widgets.add(_buildNovelImage(user.novels[i]));
      } else {
        break;
      }
    }
    while (widgets.length < 3) {
      widgets.add(DecoratedBox(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      ));
    }
    return widgets;
  }

  // 构建画作的图片
  Widget _buildArtworkImage(CommonIllust artwork) {
    return EnhanceNetworkImage(
      image: ExtendedNetworkImageProvider(
        artwork.imageUrls.squareMedium,
        headers: const {"referer": CONSTANTS.referer},
        cache: true,
      ),
    );
  }

  // 构建小说的图片
  Widget _buildNovelImage(CommonNovel novel) {
    return EnhanceNetworkImage(
      image: ExtendedNetworkImageProvider(
        novel.imageUrls.squareMedium,
        headers: const {"referer": CONSTANTS.referer},
        cache: true,
      ),
    );
  }
}
