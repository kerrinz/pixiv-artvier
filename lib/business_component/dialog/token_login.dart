import 'package:artvier/base/base_page.dart';
import 'package:artvier/global/provider/current_account_provider.dart';
import 'package:artvier/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TokenLoginDialog extends ConsumerStatefulWidget {
  const TokenLoginDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TokenLoginDialogState();
}

class _TokenLoginDialogState extends BasePageState<TokenLoginDialog> {
  final TextEditingController _refreshTokenController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void dispose() {
    _refreshTokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Token"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              autofocus: false,
              controller: _refreshTokenController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.end,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                isCollapsed: true,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(i10n.promptCancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: ValueListenableBuilder<bool>(
            valueListenable: isLoading,
            builder: (BuildContext context, value, Widget? child) {
              return value
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(i10n.promptConform);
            },
          ),
          onPressed: () {
            if (isLoading.value) return;
            isLoading.value = true;
            ref
                .read(globalCurrentAccountProvider.notifier)
                .loginByRefreshToken(_refreshTokenController.text)
                .then((value) {
              if (value && context.mounted) {
                Fluttertoast.showToast(msg: i10n.loginSuccess);
                Navigator.of(context).pushNamedAndRemoveUntil(RouteNames.mainNavigation.name, (route) => false);
              }
              if (!value) {
                Fluttertoast.showToast(msg: i10n.loginFailed);
              }
            }).catchError((e) {
              Fluttertoast.showToast(msg: i10n.loginFailed + e.toString());
            }).whenComplete(() => isLoading.value = false);
          },
        ),
      ],
    );
  }
}
