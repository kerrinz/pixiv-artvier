import 'package:flutter/material.dart';
import 'package:pixgem/store/download_store.dart';

class DownloadTaskTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DownloadTaskTabPageState();
}

class DownloadTaskTabPageState extends State<DownloadTaskTabPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("asdasdasd", style: TextStyle(fontSize: 18)),
                      Text("process"),
                    ],
                  ),
                ),
                Icon((Icons.close)),
              ],
            ),
          ),
        );
      },
      itemCount: 10,
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    var illust = DownloadStore.getDownloadedIllusts();
  }
}


