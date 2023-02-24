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
}
