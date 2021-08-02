import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixgem/config/constants.dart';
import 'package:pixgem/model_response/illusts/common_illust.dart';
import 'package:provider/provider.dart';

/*
* 传入参数：List<ArtworksImageUrls>
* */
class PreviewArtworksPage extends StatefulWidget {
  late List<Image_urls> urlList; // 图片集合，每张图片有标清和高清两种模式

  PreviewArtworksPage(Object arguments, {Key? key}) : super(key: key) {
    urlList = arguments as List<Image_urls>;
  }

  @override
  State<StatefulWidget> createState() {
    return _PreviewArtworksState();
  }
}

class _PreviewArtworksState extends State<PreviewArtworksPage> with SingleTickerProviderStateMixin {
  late TabController mController;
  _PreviewProvider _provider = new _PreviewProvider();

  @override
  void initState() {
    super.initState();
    mController = TabController(
      length: widget.urlList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    mController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (BuildContext context) => _provider,
        child: Stack(
          children: [
            Positioned(child: Container(color: Colors.black)),
            TabBarView(
              controller: mController,
              children: widget.urlList.map((item) {
                return _buildPreviewImage(context, item);
              }).toList(),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Material(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.only(left: 2, right: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        tooltip: "关闭",
                        color: Colors.white,
                        iconSize: 26,
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.file_download),
                              onPressed: () {},
                              tooltip: "下载",
                              color: Colors.white,
                              iconSize: 26,
                            ),
                            Selector(
                              builder: (BuildContext context, bool isHdMode, Widget? child) {
                                if (isHdMode) {
                                  return IconButton(
                                    icon: Icon(Icons.hd),
                                    onPressed: () {
                                      _provider.setHdMode(!isHdMode);
                                    },
                                    tooltip: "切换到标清模式",
                                    color: Colors.white,
                                    iconSize: 26,
                                  );
                                }
                                return IconButton(
                                  icon: Icon(Icons.hd_outlined),
                                  onPressed: () {
                                    _provider.setHdMode(!isHdMode);
                                  },
                                  tooltip: "切换到高清/原图模式",
                                  color: Colors.white,
                                  iconSize: 26,
                                );
                              },
                              selector: (context, _PreviewProvider provider) {
                                return provider.isHdMode;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewImage(BuildContext context, Image_urls item) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: GestureDetector(
        onDoubleTap: () {},
        onTap: () {
          Navigator.pop(context);
        },
        child: Selector(
          builder: (BuildContext context, bool isHdMode, Widget? child) {
            if (isHdMode) {
              return Image.network(
                item.original!,
                headers: {"referer": CONSTANTS.referer},
              );
            }
            return Image.network(
            item.large,
            headers: {"referer": CONSTANTS.referer},
            );
          },
          selector: (context, _PreviewProvider provider) {
            return provider.isHdMode;
          },
        ),
      ),
    );
  }
}

class _PreviewProvider with ChangeNotifier {
  bool isHdMode = false; // 是否高清模式

  void setHdMode(bool isHdMode) {
    this.isHdMode = isHdMode;
    notifyListeners();
  }
}
