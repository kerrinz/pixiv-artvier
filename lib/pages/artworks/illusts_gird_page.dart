import 'package:flutter/material.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:pixgem/widgets/pic_list_gird.dart';

class IllustGirdTabPage extends StatefulWidget {
  final List<CommonIllust>? illustList; // 插画（或漫画）列表
  final Function onLazyLoad; // 加载更多的函数
  final RefreshCallback onRefresh; // 刷新的函数

  @override
  State<StatefulWidget> createState() => IllustGirdTabPageState();

  IllustGirdTabPage({
    Key? key,
    required this.onLazyLoad,
    required this.onRefresh,
    required this.illustList,
  }) : super(key: key);
}

class IllustGirdTabPageState extends State<IllustGirdTabPage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        await widget.onRefresh();
      },
      child: PicListGird(
        artworkList: widget.illustList ?? [],
        onLazyLoad: widget.onLazyLoad,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    widget.onRefresh();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}