import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/global/provider/current_account_provider.dart';
import 'package:pixgem/pages/account/account_manage/logic.dart';
import 'package:pixgem/pages/account/account_manage/provider/account_manage_provider.dart';
import 'package:pixgem/storage/model/account_profile.dart';
import 'package:pixgem/base/base_page.dart';

class AccountManagePage extends BaseStatefulPage {
  const AccountManagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountManagePageState();
}

class _AccountManagePageState extends BasePageState<AccountManagePage> with AccountManagePageStateLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("多帐号切换"),
        actions: [
          IconButton(
            onPressed: handlePressedAdd,
            icon: const Icon(Icons.add),
            tooltip: "添加帐号",
          ),
        ],
      ),
      body: Consumer(
        // 帐号列表
        builder: (_, ref, __) {
          Map<String, AccountProfile> accountsMap = ref.watch(accountManageProvider);
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()), // ListView内容不足也能搞出回弹效果
            itemBuilder: (BuildContext context, int index) {
              var list = accountsMap.values.toList();
              return _accountCardWidget(list[index]);
            },
            itemCount: accountsMap.length,
          );
        },
      ),
    );
  }

  // 帐号卡片
  Widget _accountCardWidget(AccountProfile profile) {
    Widget avatar; // 头像的图片widget
    if (profile.user.profileImageUrls == null) {
      // 未登录或者原本就无头像用户
      avatar = const Image(image: AssetImage("assets/images/default_avatar.png"));
    } else {
      avatar = ExtendedImage.network(
        profile.user.profileImageUrls!.px170x170,
        headers: const {"Referer": CONSTANTS.referer},
        enableLoadState: false,
      );
    }
    return InkWell(
      onTap: () => handleTapAccountCard(profile),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  SizedBox(
                    height: 64,
                    width: 64,
                    child: ClipOval(
                      child: avatar,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profile.user.name,
                          style: const TextStyle(
                            fontSize: 20,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          profile.user.mailAddress,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            profile.user.id != ref.watch(globalCurrentAccountProvider)?.user.id
                ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_forever_rounded, color: Colors.transparent),
                  )
                : IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.secondary),
                  ),
          ],
        ),
      ),
    );
  }
}
