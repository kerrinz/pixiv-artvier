import 'package:flutter/material.dart';

class SettingDownload extends StatefulWidget {
  const SettingDownload({super.key});

  @override
  State<StatefulWidget> createState() => SettingDownloadState();
}

class SettingDownloadState extends State<SettingDownload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("图片保存方式"),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        child: Container(
          // 这样解决了内容不足以支撑全屏时，滑动回弹不会回到原位的问题
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height -
                MediaQuery.paddingOf(context).top -
                MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _buildCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Expanded(
      child: Card(
        elevation: 1.5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            InkWell(
              onTap: null,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Expanded(child: Text("保存到系统相册（默认）", style: TextStyle(fontSize: 16))),
                    Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.secondary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
