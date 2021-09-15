import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/request/oauth.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class AccountManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountManagePageState();
}

class AccountManagePageState extends State<AccountManagePage> {
  _AccountManageProvider _provider = _AccountManageProvider();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text("多帐号切换"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed("login_wizard");
              },
              icon: Icon(Icons.add),
              tooltip: "添加帐号",
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                child: Selector(
                  // 帐号列表
                  builder: (BuildContext context,
                      Map<String, AccountProfile>? profilesMap, Widget? child) {
                    if (profilesMap == null) {
                      return SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: Theme.of(context).accentColor));
                    }
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        var list = profilesMap.values.toList();
                        return _buildAccountCard(context, list[index]);
                        return Container(child: Text("无"));
                      },
                      itemCount: profilesMap.length,
                    );
                  },
                  selector:
                      (BuildContext context, _AccountManageProvider provider) {
                    return provider.profilesMap;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 帐号卡片
  Widget _buildAccountCard(BuildContext context, AccountProfile profile) {
    var avatar; // 头像的图片widget
    if (profile == null || profile.user.profileImageUrls == null) {
      // 未登录或者原本就无头像用户
      avatar = Image(image: AssetImage("assets/images/default_avatar.png"));
    } else {
      avatar = CachedNetworkImage(
        imageUrl: profile.user.profileImageUrls!.px170x170,
        httpHeaders: {"Referer": CONSTANTS.referer},
      );
    }
    return InkWell(
      onTap: () async {
        // 切换帐号
        await AccountStore.setCurrentAccountId(id: profile.user.id);
        var newProfile = await OAuth().refreshToken(profile.refreshToken);
        await OAuth().saveTokenToCurrent(newProfile);
        this.readProfiles();
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Container(
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
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.4,
                          ),
                        ),
                        Text(
                          profile.user.mailAddress,
                          style: TextStyle(
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
            Builder(builder: (context) {
              if (profile.user.id != GlobalStore.currentAccount!.user.id) {
                return IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_forever_rounded,
                        color: Colors.grey.shade300));
              } else {
                return IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.done_rounded,
                        color: Theme.of(context).accentColor));
              }
            }),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    readProfiles();
  }

  // 读取配置数据
  void readProfiles() {
    AccountStore.getAllAccountsProfile()
        .then((map) => _provider.setAccountProfiles(map))
        .catchError((onError) => Fluttertoast.showToast(
            msg: "读取失败！$onError",
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16.0));
  }
}

class _AccountManageProvider with ChangeNotifier {
  Map<String, AccountProfile>? profilesMap;

  setAccountProfiles(Map<String, AccountProfile>? profilesMap) {
    this.profilesMap = profilesMap;
    notifyListeners();
  }
}
