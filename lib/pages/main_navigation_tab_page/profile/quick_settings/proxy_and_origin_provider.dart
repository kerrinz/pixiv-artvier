import 'package:flutter/widgets.dart';

class NetworkSettingProvider with ChangeNotifier {
  String? host;
  String? port;

  NetworkSettingProvider(this.host, this.port) : super();
}
