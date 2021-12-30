import 'package:flutter/material.dart';

///
/// 用于设置项的单选（多个项选一个）的面板
///
///
typedef OnSelectCallback = Function(int selectedIndex);

class PerferenceSingleChoisePanel extends StatelessWidget {
  final List<Widget> widgets; // 选择项
  final String title; // 标题
  final int? selectedindex; // 已选项
  final OnSelectCallback onSelect;

  const PerferenceSingleChoisePanel({
    Key? key,
    required this.title,
    required this.widgets,
    required this.onSelect,
    this.selectedindex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 1.5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              side: BorderSide(width: 1, color: Colors.white12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Builder(builder: (context) {
              return Column(
                children: [
                  for (int i = 0; i < widgets.length; i++) _buildItem(context, i), //
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return InkWell(
      onTap: () => onSelect(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
        child: Row(
          children: [
            Expanded(child: widgets[index]),
            Icon(
              Icons.done,
              color: selectedindex == index ? Theme.of(context).colorScheme.secondary : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
