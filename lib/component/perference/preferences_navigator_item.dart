import 'package:flutter/material.dart';

class PreferencesNavigatorItem extends StatelessWidget {
  final String text;
  final Widget? icon;
  final String routeName;

  const PreferencesNavigatorItem({Key? key, required this.text, this.icon, required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: icon ?? Container(),
                ),
                Text(text, style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
