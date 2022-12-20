import 'package:flutter/material.dart';
import 'package:pixgem/component/layout/size_reporting_widget.dart';
import 'package:pixgem/component/scroll_view/extend_tab_bar_view.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/pages/artwork/detail/widgets/tabpage_info.dart';
import 'package:pixgem/pages/artwork/detail/widgets/tabpage_similar.dart';
import 'package:pixgem/pages/comment/comments_tabpage.dart';

/// Artworks Detail Page
///
/// 拖拽抽屉组件的滚动内容
class DragContentScroll extends StatefulWidget {
  final CommonIllust detail;

  final TabController tabController;

  const DragContentScroll({Key? key, required this.detail, required this.tabController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DragContentScrollState();
}

class _DragContentScrollState extends State<DragContentScroll> with TickerProviderStateMixin {
  CommonIllust get detail => widget.detail;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendTabBarView(
      controller: widget.tabController,
      autoHeight: false,
      children: [
        SingleChildScrollView(
          child: SizeReportingWidget(
            onSizeChange: ((value) {
              PageViewContentSizeChangedReportingNotification(0, value).dispatch(context);
            }),
            child: InfoTabPage(detail: detail),
          ),
        ),
        Center(
          child: SizeReportingWidget(
            onSizeChange: ((value) {
              PageViewContentSizeChangedReportingNotification(1, value).dispatch(context);
            }),
            child: CommentsPage(detail.id.toString()),
          ),
        ),
        Center(
          child: SizeReportingWidget(
            onSizeChange: ((value) {
              PageViewContentSizeChangedReportingNotification(2, value).dispatch(context);
            }),
            child: SimilarWorksTabPage2(artworkId: detail.id.toString()),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

/// 当PageView分页内容的Size发生改变时，通知上层组件
class PageViewContentSizeChangedReportingNotification extends Notification {
  final Size? size;

  final int index;

  const PageViewContentSizeChangedReportingNotification(this.index, this.size);
}
