import 'package:flutter/material.dart';

class MyWorksPage extends StatefulWidget {
  const MyWorksPage(Object? arguments, {super.key});

  @override
  State<StatefulWidget> createState() => _MyBookmarksState();
}

class _MyBookmarksState extends State<MyWorksPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Empty"),
      ),
    );
  }
}
