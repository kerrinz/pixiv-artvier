import 'package:artvier/base/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutAppPage extends ConsumerStatefulWidget {
  const AboutAppPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends BasePageState<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(i10n.aboutApp),
      ),
      body: Container(),
    );
  }
}
