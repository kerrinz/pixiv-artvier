import 'package:artvier/base/base_page.dart';
import 'package:artvier/database/database.dart';
import 'package:artvier/database/database_migration.dart';
import 'package:artvier/global/logger.dart';
import 'package:artvier/pages/framework/booting/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/routes.dart';

/// app启动的加载过渡页面，处理一些数据
class BootingPage extends ConsumerStatefulWidget {
  const BootingPage(Object args, {super.key}) : arguemnts = args as BootingPageArguments;

  final BootingPageArguments arguemnts;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => BootingPageState();
}

class BootingPageState extends BasePageState<BootingPage> {
  final ValueNotifier<bool> isUpdating = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/icon/ic_launcher.png"),
              width: 128,
              height: 128,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: CircularProgressIndicator(strokeWidth: 2.0, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isUpdating,
              builder: (BuildContext context, value, Widget? child) {
                return value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Text(l10n.bootingPageUpdatingHint),
                      )
                    : const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    process().catchError((err) => logger.e(err)).whenComplete(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        String? id = ref.read(globalCurrentAccountProvider)?.user.id;
        if (id == null) {
          // 拦截未登录
          Navigator.pushNamedAndRemoveUntil(context, RouteNames.wizard.name, (route) => false);
        } else {
          if (context.mounted) {
            // ignore: use_build_context_synchronously
            Navigator.pushNamedAndRemoveUntil(context, widget.arguemnts.nextRoute, (route) => false);
          }
        }
      });
    });
  }

  /// 执行任务
  Future<void> process() async {
    final needsMigrateDatabase = await DatabaseMigration.needsMigration();
    if (needsMigrateDatabase) {
      isUpdating.value = true;
      // 执行数据库迁移
      logger.d('开始数据库迁移...');
      await DatabaseMigration.migrateToNewDatabase(appDatabase);
      logger.d('结束数据库迁移...');
    }
  }
}
