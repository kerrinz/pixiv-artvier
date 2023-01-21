import 'package:flutter/material.dart';

class TagListItemWidget extends StatelessWidget {
  final String name;
  final int? count;
  final bool isActived;
  final void Function() onTap;

  const TagListItemWidget({
    super.key,
    required this.name,
    required this.count,
    required this.isActived,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child: Material(
        shadowColor: Colors.transparent,
        color: isActived ? Theme.of(context).colorScheme.secondaryContainer : Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                  color: isActived ? Theme.of(context).colorScheme.primary.withAlpha(100) : Colors.transparent),
            ),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isActived ? FontWeight.w500 : FontWeight.w400,
                color: isActived ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
