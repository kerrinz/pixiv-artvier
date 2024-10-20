import 'package:artvier/config/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalCurrentWorksTypeProvider = Provider<WorksType>((ref) {
  return WorksType.illust;
});
