import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgem/l10n/localization_intl.dart';

abstract class BasePage extends ConsumerWidget {
  const BasePage({super.key});
}

abstract class BaseStatefulPage extends ConsumerStatefulWidget {
  const BaseStatefulPage({super.key});
}

abstract class BasePageState<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  LocalizationIntl get i10n => LocalizationIntl.of(context);
  ColorScheme get colorScheme => Theme.of(context).colorScheme;
}
