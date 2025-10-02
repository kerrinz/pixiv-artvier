import 'package:artvier/pages/user/detail/provider/user_follow_provider.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:artvier/component/text/collapsible_text.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:artvier/model_response/user/user_detail.dart';
import 'package:artvier/pages/artwork/detail/widgets/user_follow_button.dart';
import 'package:artvier/pages/user/detail/provider/user_detail_provider.dart';
import 'package:artvier/routes.dart';

/// 用户详情页的用户面板组件
class UserDetailPageUserPanelWidget extends ConsumerWidget {
  const UserDetailPageUserPanelWidget({
    super.key,
    required this.userId,
    required this.userName,
    required this.avatarUrl,
    required this.avatarDiameter,
  });

  final String userId;

  final String userName;

  final String? avatarUrl;

  /// 头像的直径
  final double avatarDiameter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var l10n = LocalizationIntl.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 左侧的头像
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  width: avatarDiameter,
                  height: avatarDiameter,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: const BorderRadius.all(Radius.circular(80)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: (avatarUrl != null)
                          ? ExtendedNetworkImageProvider(
                              HttpHostOverrides().pxImgUrl(avatarUrl!),
                              headers: HttpHostOverrides().pximgHeaders,
                            )
                          : ExtendedAssetImageProvider('assets/image/default_avatar.png') as ImageProvider<Object>,
                    ),
                  ),
                ),
              ),
              // 右侧
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Consumer(
                      builder: (_, ref, __) => ref.watch(userDetailProvider(userId)).when(
                            error: (_, __) => Container(),
                            loading: () => Container(),
                            data: (detail) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 右侧的水平分栏信息
                                _rightHorizontalColumnsWidget(context, detail),
                                // 右侧的关注按钮
                                _followButton(detail),
                              ],
                            ),
                          ),
                    ),
                  )),
            ],
          ),
          // 用户名
          Consumer(builder: (_, ref, __) {
            return ref.watch(userDetailProvider(userId)).when(
                  error: (_, __) => _userNameWidget(userName),
                  loading: () => _userNameWidget(userName),
                  data: (detail) => _userNameWidget(detail.user.name),
                );
          }),
          // UID信息
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              // 点击复制UID
              Clipboard.setData(ClipboardData(text: userId)).then(
                (value) => Fluttertoast.showToast(
                  msg: l10n.copiedToClipboard,
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 16.0,
                ),
              );
            },
            child: Row(
              children: [
                Text("UID: $userId", style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0), child: Icon(Icons.copy, size: 12)),
              ],
            ),
          ),
          // 个人介绍
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            child: Consumer(
              builder: (_, ref, __) {
                return ref.watch(userDetailProvider(userId)).when(
                      data: (data) => CollapsibleText(
                        text: data.user.comment ?? "",
                        style: const TextStyle(fontSize: 14),
                        collapsedMaxLine: 3,
                        isCollapsedInitially: true,
                        isSelectable: true,
                        buttonAxisAlignment: MainAxisAlignment.end,
                      ),
                      error: (_, __) => Container(),
                      loading: () => Container(),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 用户名组件
  Widget _userNameWidget(String name) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 8.0, bottom: 2.0),
      child: SelectableText(
        name,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// 右侧的水平分栏信息
  Widget _rightHorizontalColumnsWidget(BuildContext context, UserDetail detail) {
    var l10n = LocalizationIntl.of(context);
    const TextStyle numberTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    // 性别、关注、好P友的统计信息
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 性别
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(l10n.gender, style: Theme.of(context).textTheme.labelSmall),
              Builder(builder: (_) {
                var gender = detail.profile.gender;
                switch (gender) {
                  case "male":
                    return const Icon(Icons.male, color: Colors.blue, size: 22);
                  case "female":
                    return Icon(Icons.female, color: Colors.pink.shade300.withValues(alpha: 0.75), size: 22);
                  case "unknown":
                    return Icon(Icons.transgender_outlined, color: Colors.blueGrey.withValues(alpha: 0.75), size: 22);
                  default:
                    return const Text("-", style: numberTextStyle);
                }
              }),
            ],
          ),
        ),
        // 关注数
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(RouteNames.userFollowing.name, arguments: userId),
            child: Column(
              children: [
                Text(l10n.following, style: Theme.of(context).textTheme.labelSmall),
                Text(detail.profile.totalFollowUsers.toString(), style: numberTextStyle),
              ],
            ),
          ),
        ),
        // 好P友数
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Text(l10n.friends, style: Theme.of(context).textTheme.labelSmall),
              Text(detail.profile.totalMypixivUsers.toString(), style: numberTextStyle),
            ],
          ),
        ),
      ],
    );
  }

  /// 关注按钮
  Widget _followButton(UserDetail detail) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Consumer(builder: (context, ref, child) {
                return UserFollowButton(
                  userId: userId,
                  followState: ref.watch(userFollowStateProvider(userId)),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
