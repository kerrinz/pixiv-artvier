import 'package:dio/dio.dart';

/// 表单工具
class FormUtil {
  /// 将 FormData 中的字段（key-value 部分，不含文件）转换成 JSON Map
  static Map<String, dynamic> formDataToJsonMap(FormData formData) {
    final Map<String, dynamic> json = {};
    for (final field in formData.fields) {
      json[field.key] = field.value;
    }
    return json;
  }
}
