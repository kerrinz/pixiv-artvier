import 'package:pixgem/common_provider/base_provider.dart';

class NetworkSettingProvider extends BaseProvider {
  String? host;
  String? port;

  NetworkSettingProvider(this.host, this.port) : super();
}
