/// 用于传输筛选条件（插画漫画与小说可以通用）
class FilterModel {
  String restrict;

  /// 为null时为不根据tag筛选
  String? tag;

  FilterModel(this.restrict, this.tag);

  FilterModel copyWith() {
    return FilterModel(restrict, tag);
  }

  void update(String restrict, String? tag) {
    this.restrict = restrict;
    this.tag = tag;
  }

  void setRestrict(String restrict) {
    this.restrict = restrict;
  }

  void setTag(String? tag) {
    this.tag = tag;
  }
}