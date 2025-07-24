import 'package:artvier/component/badge.dart';
import 'package:artvier/component/buttons/blur_button.dart';
import 'package:artvier/request/http_host_overrides.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/pages/account/account_manage/logic.dart';
import 'package:artvier/pages/account/account_manage/provider/account_manage_provider.dart';
import 'package:artvier/global/model/account_profile/account_profile.dart';
import 'package:artvier/base/base_page.dart';

class AccountManagePage extends BaseStatefulPage {
  const AccountManagePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountManagePageState();
}

class _AccountManagePageState extends BasePageState<AccountManagePage> with AccountManagePageStateLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.switchAccount),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ValueListenableBuilder<bool>(
              valueListenable: isEditMode,
              builder: (_, isEdit, __) {
                return BlurButton(
                  onPressed: handlePressedEdit,
                  background: Colors.transparent,
                  child: isEdit ? Text(l10n.cancel) : Text(l10n.edit),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (_, ref, __) {
          Map<String, AccountProfile> accountsMap = ref.watch(accountManageProvider);
          final accountList = accountsMap.values.toList();
          return ValueListenableBuilder<bool>(
              valueListenable: isEditMode,
              builder: (_, isEdit, __) {
                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  slivers: [
                    // 提示语
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 12, right: 12, top: 56, bottom: 32),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          isEdit ? l10n.deleteAccount : l10n.tabToSwitchAccount,
                          textAlign: TextAlign.center,
                          style: textTheme.titleLarge,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            //账号列表
                            if (index < accountList.length) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: _accountCardWidget(isEdit: isEdit, profile: accountList[index]),
                              );
                            }
                            // 登录其他账号
                            return isEdit
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: _accountMoreCard(),
                                  );
                          },
                          childCount: accountsMap.length + 1,
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }

  Widget _accountMoreCard() {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          splashFactory: InkSparkle.splashFactory,
          onTap: () => handleTapLoginOtherAccount(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                SizedBox(
                  height: 56,
                  width: 56,
                  child: ClipOval(
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.1)), child: const Icon(Icons.add)),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.loginOtherAccount,
                          style: textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 帐号卡片
  Widget _accountCardWidget({required AccountProfile profile, required bool isEdit}) {
    Widget avatar; // 头像的图片widget
    if (profile.user.profileImageUrls == null) {
      // 未登录或者原本就无头像用户
      avatar = const Image(image: AssetImage("assets/image/default_avatar.png"));
    } else {
      avatar = ExtendedImage.network(
        HttpHostOverrides().pxImgUrl(profile.user.profileImageUrls!.px170x170),
        headers: HttpHostOverrides().pximgHeaders,
        enableLoadState: false,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          splashFactory: InkSparkle.splashFactory,
          onTap: isEdit ? null : () => handleTapAccountCard(profile),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                SizedBox(
                  height: 56,
                  width: 56,
                  child: ClipOval(
                    child: avatar,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.user.name,
                          style: textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(profile.user.mailAddress, style: textTheme.bodySmall),
                        ),
                      ],
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  final currrentProfile = ref.watch(globalCurrentAccountProvider);
                  if (isEdit) {
                    return MyBadge(
                      onTap: () => handleTapDelete(profile, currrentProfile),
                      color: Colors.redAccent,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Text(
                        l10n.delete,
                        style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                      ),
                    );
                  }
                  if (profile.user.id == currrentProfile?.user.id) {
                    return MyBadge(
                      color: colorScheme.primary.withValues(alpha: 0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Text(l10n.current),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
