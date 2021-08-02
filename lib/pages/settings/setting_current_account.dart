import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pixgem/model_store/account_profile.dart';
import 'package:pixgem/request/oauth.dart';
import 'package:pixgem/store/account_store.dart';
import 'package:pixgem/store/global.dart';
import 'package:provider/provider.dart';

class SettingCurrentAccountPage extends StatefulWidget {
  final String? userId;

  SettingCurrentAccountPage({Key? key, this.userId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SettingCurrentAccountState();
  }
}

class _SettingCurrentAccountState extends State<SettingCurrentAccountPage> {
  _Provider _provider = _Provider();

  TextEditingController _userIdController = new TextEditingController();
  TextEditingController _tokenController = new TextEditingController();
  TextEditingController _refreshTokenController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.userId == null) {
      // 加载当前账号配置
      loadCurrentProfile().catchError((err) {
        Fluttertoast.showToast(msg: "加载失败！$err", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
        print(err);
      });
    }
    _provider.setLoading(isLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _provider,
      child: Scaffold(
        appBar: new AppBar(
          title: new Text('设置当前账号'),
          backgroundColor: Colors.blueGrey,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Selector(
              builder: (BuildContext context, bool isLoading, Widget? child) {
                if (isLoading) {
                  return _buildLoading(context);
                }
                return Column(
                  children: [
                    TextField(
                      style: TextStyle(fontSize: 18),
                      controller: _userIdController,
                      decoration: InputDecoration(labelText: "用户id"),
                      onChanged: (value) {
                        _userIdController.text = value;
                      },
                    ),
                    TextField(
                      style: TextStyle(fontSize: 18),
                      controller: _tokenController,
                      decoration: InputDecoration(labelText: "token"),
                      onChanged: (value) {
                        _tokenController.text = value;
                      },
                    ),
                    TextField(
                      style: TextStyle(fontSize: 18),
                      controller: _refreshTokenController,
                      decoration: InputDecoration(labelText: "refresh_token"),
                      onChanged: (value) {
                        _refreshTokenController.text = value;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        saveToCurrent().then((value) {
                          Fluttertoast.showToast(msg: "保存成功", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                          Navigator.pop(context);
                        }).catchError((onError) {
                          Fluttertoast.showToast(msg: "保存失败！$onError", toastLength: Toast.LENGTH_SHORT, fontSize: 16.0);
                          print(onError);
                        });
                      },
                      child: Text("保存并设为当前账号"),
                    ),
                  ],
                );
              },
              selector: (context, _Provider provider) {
                return provider.isLoading;
              },
            ),
          ),
        ),
      ),
    );
  }

  // 加载当前账号配置
  Future loadCurrentProfile() async {
    AccountProfile? profile = await AccountStore.getCurrentAccountProfile();
    if (profile != null) {
      _userIdController.text = profile.user.id;
      _tokenController.text = profile.accessToken;
      _refreshTokenController.text = profile.refreshToken;
    }
  }

  // 保存为当前账号
  Future saveToCurrent() async {
      // 获取本地已缓存的所有账号
      Map<String, AccountProfile>? map = await AccountStore.getAllAccountsProfile(); // 临时map，账号集合
      AccountProfile profile; // 临时单账号配置（需要保存的账号）
      // 总账号缓存不存在，新建
      if (map == null) {
        map = new Map<String, AccountProfile>();
        profile = new AccountProfile(_tokenController.text, 0, "Bearer", "", _refreshTokenController.text, new User(null, _userIdController.text, "", "", "", false, 0, false, false));
        map.putIfAbsent(_userIdController.text, () => profile);
      } else if (map[_userIdController.text] != null) {
        // 总账号缓存存在，并且有这个账号，变更信息
        profile = map[_userIdController.text]!;
        profile.user.id = _userIdController.text;
        profile.accessToken = _tokenController.text;
        profile.refreshToken = _refreshTokenController.text;
        map[_userIdController.text] = profile; // 更新临时map
      } else {
        // 总账号缓存存在，但不存在这个账号
        profile = new AccountProfile(_refreshTokenController.text, 0, "Bearer", "", _refreshTokenController.text, new User(null, _userIdController.text, "", "", "", false, 0, false, false));
        map.putIfAbsent(_userIdController.text, () => profile);
      }
      await AccountStore.setAllAccountsProfile(map);
      await AccountStore.setCurrentAccountId(id: _userIdController.text);
      // 设置为全局账号信息
      GlobalStore.changeCurrentAccount(profile);
  }

  // 构建加载动画
  Widget _buildLoading(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(strokeWidth: 2.0)),
    );
  }
}

/* Provider
 */
class _Provider with ChangeNotifier {
  bool isLoading = true; // 是否正在加载

  void setLoading({required isLoading}) {
    this.isLoading = isLoading;
  }
}
