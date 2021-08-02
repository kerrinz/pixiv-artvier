import 'package:flutter/material.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/pages/login/select_login_method_page.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyDrawerState();
  }
}

class MyDrawerState extends State {
  _AccountInfoProvider _provider = new _AccountInfoProvider();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: ChangeNotifierProvider(
          create: (BuildContext context) => _provider,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      return Image.network(
                        "https://i.pximg.net/c/720x360_80_a2_g5/background/img/2021/05/16/21/41/25/18975881_2276b6a4e8756e65733066aef6ef2cb4_master1200.jpg",
                        headers: {"referer": CONSTANTS.referer},
                        height: 180,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Positioned(
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0x67000000),
                          Color(0x26000000),
                        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            width: 64,
                            height: 64,
                            child: ClipOval(
                              child: Consumer(
                                builder: (BuildContext context, _AccountInfoProvider provider, Widget? child) {
                                  if (provider.account == null) {
                                    return Container(width: 50, height: 50);
                                  }
                                  return Image.network(
                                    provider.account!.user.profileImageUrls!.px170x170,
                                    headers: {"referer": CONSTANTS.referer},
                                    height: 50,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16, top: 8, bottom: 16),
                            child: Consumer(
                              builder: (BuildContext context, _AccountInfoProvider provider, Widget? child) {
                                if (provider.account == null) {
                                  return Text("");
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.account!.user.name,
                                        style: TextStyle(color: Colors.white, fontSize: 15)),
                                    Text(provider.account!.user.mailAddress, style: TextStyle(color: Colors.white)),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 38.0),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return SelectLoginPage();
                          }));
                        },
                        child: Text("Login")),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed("my_illusts_bookmark");
                      },
                      child: ListTile(
                        leading: const Icon(Icons.photo_size_select_actual_rounded),
                        title: const Text('我的插画收藏'),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Manage accounts'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setAccount();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    setAccount();
  }

  setAccount() async {
    // Account? current = await AccountStore.getCurrentAccountProfile();
    // if (current != null) {
    //   _provider.setData(current);
    //   print(current.toJson().toString());
    // }
  }
}

/* Provider
 */
class _AccountInfoProvider with ChangeNotifier {
  AccountProfile? account;

  void setData(AccountProfile value) {
    account = value;
    notifyListeners();
  }
}
