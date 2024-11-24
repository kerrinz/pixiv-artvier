import 'package:artvier/model_response/novels/common_novel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin NovelDetailPageLogic {
  WidgetRef get ref;

  /// 作品详细信息
  late CommonNovel? novelDetail;

  /// 作品ID
  late String worksId;
}
