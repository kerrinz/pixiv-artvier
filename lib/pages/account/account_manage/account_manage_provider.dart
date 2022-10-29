import 'package:pixgem/common_provider/base_provider.dart';
import 'package:pixgem/model_store/account_profile.dart';

class AccountManageProvider extends BaseProvider {
  Map<String, AccountProfile>? profilesMap;

  setAccountProfiles(Map<String, AccountProfile>? profilesMap) {
    this.profilesMap = profilesMap;
    notifyListeners();
  }
}