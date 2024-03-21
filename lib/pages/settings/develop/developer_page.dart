import 'package:artvier/base/base_page.dart';
import 'package:artvier/business_component/dialog/token_login.dart';
import 'package:artvier/component/perference/perference_group.dart';
import 'package:artvier/component/perference/perference_item.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeveloperPage extends ConsumerStatefulWidget {
  const DeveloperPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends BasePageState<DeveloperPage> {
  @override
  Widget build(BuildContext context) {
    var account = ref.watch(globalCurrentAccountProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Developer settings")),
      body: Column(
        children: [
          PerferenceGroup(
            items: [
              PerferenceItem(
                text: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("refresh_token", style: textTheme.titleMedium),
                    Text(
                      account?.refreshToken ?? "null",
                      style: textTheme.labelSmall?.copyWith(
                        color: textTheme.labelSmall?.color?.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                value: Row(
                  children: [
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.edit_rounded),
                      ),
                      onTap: () => showDialog<bool>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => const TokenLoginDialog(),
                      ),
                    ),
                    InkWell(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.copy_rounded),
                      ),
                      onTap: () {
                        if (account?.refreshToken != null) {
                          Clipboard.setData(ClipboardData(text: account!.refreshToken));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
