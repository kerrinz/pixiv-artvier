import 'package:pixgem/common_provider/base_provider.dart';
import 'package:pixgem/common_provider/loading_request_provider.dart';
import 'package:pixgem/common_provider/works_provider.dart';
import 'package:pixgem/model_response/user/bookmark/bookmark_tag.dart';

class BookmarkTagsProvider extends BaseProvider {
  List<BookmarkTag> illustTags = [];
  List<BookmarkTag> novelTags = [];
  String? illustNextUrl;
  String? novelNextUrl;
  WorksType currentWorksType;

  LoadingStatus loadingStatus;

  BookmarkTagsProvider({
    this.currentWorksType = WorksType.illust,
    this.loadingStatus = LoadingStatus.loading,
  });

  void resetIllustTags(List<BookmarkTag> tags, String? nextUrl, {loadingStatus = LoadingStatus.success}) {
    illustTags.clear();
    illustTags.addAll(tags);
    illustNextUrl = nextUrl;
    this.loadingStatus = loadingStatus;
    notifyListeners();
  }

  void resetNovelTags(List<BookmarkTag> tags, String? nextUrl, {loadingStatus = LoadingStatus.success}) {
    novelTags.clear();
    novelTags.addAll(tags);
    novelNextUrl = nextUrl;
    this.loadingStatus = loadingStatus;
    notifyListeners();
  }

  void appendIllustTags(List<BookmarkTag> tags, String? nextUrl) {
    illustTags.addAll(tags);
    illustNextUrl = nextUrl;
    notifyListeners();
  }

  void appendNovelTags(List<BookmarkTag> tags, String? nextUrl) {
    illustTags.addAll(tags);
    illustNextUrl = nextUrl;
    notifyListeners();
  }

  void setWorksType(WorksType worksType) {
    currentWorksType = worksType;
    notifyListeners();
  }

  void seLoadStatus(LoadingStatus status) {
    loadingStatus = status;
    notifyListeners();
  }

  void clear() {
    currentWorksType == WorksType.illust ? illustTags.clear() : novelTags.clear();
    notifyListeners();
  }
}
