import 'package:flutter/widgets.dart';
import 'package:pixgem/model_store/account_profile.dart';

class AccountManageProvider with ChangeNotifier {
  Map<String, AccountProfile>? profilesMap;

  setAccountProfiles(Map<String, AccountProfile>? profilesMap) {
    this.profilesMap = profilesMap;
    notifyListeners();
  }
}