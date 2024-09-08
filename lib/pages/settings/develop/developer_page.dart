import 'package:artvier/base/base_page.dart';
import 'package:artvier/pages/settings/develop/widgets/refresh_token_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeveloperPage extends ConsumerStatefulWidget {
  const DeveloperPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends BasePageState<DeveloperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Developer settings")),
      body: const Column(
        children: [
          RefreshTokenSettings(),
        ],
      ),
    );
  }
}
