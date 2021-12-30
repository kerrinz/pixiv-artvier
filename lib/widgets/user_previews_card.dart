import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/user/common_user_previews.dart';
import 'package:pixgem/model_response/user/preload_user_least_info.dart';

/// 用户卡片类型
enum UserPreviewsType { illust, novel }

class UserPreviewsCard extends StatelessWidget {
  final CommonUserPreviews user;
  final UserPreviewsType type = UserPreviewsType.illust;

  const UserPreviewsCard({Key? key, required this.user, required UserPreviewsType type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imgWidth = MediaQuery.of(context).size.width / 3; // 单个图片的宽度
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shadowColor: Colors.grey.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
                  children: [
                    _buildImage(0),
                    _buildImage(1),
                    _buildImage(2),
                  ],
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
                    child: CachedNetworkImage(
                      width: 64,
                      height: 64,
                      imageUrl: user.user.profileImageUrls.medium,
                      httpHeaders: const {
                        "referer": CONSTANTS.referer,
                      },
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
                  Navigator.of(context).pushNamed("user_detail",
                      arguments: PreloadUserLeastInfo(user.user.id, user.user.name, user.user.profileImageUrls.medium));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建图片
  Widget _buildImage(int index) {
    // 当作品数量不够展示的时候进行处理
    switch (type) {
      case UserPreviewsType.illust:
        if (index >= user.illusts.length) {
          return Container(color: Colors.redAccent);
        } else {
          return Expanded(
            child: CachedNetworkImage(
              imageUrl: user.illusts[index].imageUrls.squareMedium,
              httpHeaders: const {"referer": CONSTANTS.referer},
            ),
          );
        }
      default:
        if (index >= user.novels.length) {
          return Container(color: Colors.redAccent);
        } else {
          return Expanded(
            child: CachedNetworkImage(
              imageUrl: user.novels[index].imageUrls.squareMedium,
              httpHeaders: const {"referer": CONSTANTS.referer},
            ),
          );
        }
    }
  }
}
