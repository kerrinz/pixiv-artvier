import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BasePage extends ConsumerWidget {
  const BasePage({super.key});
}

abstract class BaseStatefulPage extends ConsumerStatefulWidget {
  const BaseStatefulPage({super.key});
}

abstract class BasePageState<T extends ConsumerStatefulWidget> extends ConsumerState<T> {}
