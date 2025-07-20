/// 字符串工具
class StringUtil {
  /// 用于 `Text` 组件，以字符的方式截断而不是单词形式截断
  static String breakChars(String text) {
    if (text.isEmpty) {
      return text;
    }
    String breakWord = '';
    for (var element in text.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }

  /// 转义字符串使其能够被 JSON 转义
  static String escapeStringJsonLiterals(String input) {
    return input.replaceAllMapped(
      // 匹配双引号字符串，仅支持简单转义
      RegExp(r'"((?:[^"\\]|\\.)*?)"'),
      (m) {
        final original = m.group(1)!;
        // 转义字符串中的换行、回车、制表符
        final escaped = original.replaceAll('\n', r'\\n').replaceAll('\r', r'\\r').replaceAll('\t', r'\\t');
        return '"$escaped"';
      },
    );
  }

  /// 提取 JS 中的 JSON 格式值
  static String? extractJsonValueInJs(String html, String jsKey, {int startAt = 0}) {
    final keyIndex = html.indexOf('$jsKey:', startAt);
    if (keyIndex == -1) return null;

    final startBrace = html.indexOf('{', keyIndex);
    if (startBrace == -1) return null;

    // 大括号未闭合统计，为0时大括号闭合
    int braceCount = 0;
    for (int i = startBrace; i < html.length; i++) {
      if (html[i] == '{') braceCount++;
      if (html[i] == '}') braceCount--;
      if (braceCount == 0) {
        String value = html
            .substring(startBrace, i) // 失去最后一个右大括号
            .trim();
        // 干掉不应该出现的最后一个逗号
        if (value.endsWith(',')) {
          value = value.substring(0, value.length - 1);
        }
        return '$value}';
      }
    }

    return null; // 匹配失败
  }

  /// 提取 HTML 中 Object.defineProperty(window, 'pixiv', { value: {...} }) 中的 novel 对象
  static String? extractPixivNovelWebview(String html) {
    final index = html.indexOf("Object.defineProperty(window, 'pixiv'");
    if (index == -1) return null;

    final valueIndex = html.indexOf('value:', index);
    if (valueIndex == -1) return null;

    final startBrace = html.indexOf('{', valueIndex);
    if (startBrace == -1) return null;

    // 大括号未闭合统计，为0时大括号闭合
    int braceCount = 0;
    for (int i = startBrace; i < html.length; i++) {
      if (html[i] == '{') braceCount++;
      if (html[i] == '}') braceCount--;
      if (braceCount == 0) {
        String value = html
            .substring(startBrace, i) // 失去最后一个右大括号
            .trim()
            // 转化 List 和 Map 格式
            .replaceFirst('"illusts": []', '"illusts":{}')
            .replaceFirst('"images": []', '"images":{}')
            .replaceFirst('"illusts":[]', '"illusts":{}')
            .replaceFirst('"images":[]', '"images":{}');
        // 干掉不应该出现的最后一个逗号
        if (value.endsWith(',')) {
          value = value.substring(0, value.length - 1);
        }
        return '$value}';
      }
    }

    return null; // 匹配失败
  }
}
