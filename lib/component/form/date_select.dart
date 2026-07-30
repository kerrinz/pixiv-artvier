import 'package:artvier/component/bottom_sheet/bottom_sheets.dart';
import 'package:artvier/component/bottom_sheet/slide_bar.dart';
import 'package:artvier/l10n/localization_intl.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 日期选择相关 BottomSheet
class DatePickerSheets {
  DatePickerSheets._();

  static String formatDateValue(DateTime date) => formatDate(date, [yyyy, '-', mm, '-', dd]);

  /// 单个日期选择：日期选择器 + 取消 / 确定
  static Future<DateTime?> showDatePicker(
    BuildContext context, {
    DateTime? initialDateTime,
    DateTime? minimumDate,
    DateTime? maximumDate,
    bool useRootNavigator = true,
  }) {
    var selected = _clampInitial(
      initialDateTime ?? DateTime.now(),
      minimumDate: minimumDate,
      maximumDate: maximumDate,
    );
    final l10n = LocalizationIntl.of(context);

    return BottomSheets.showCustomBottomSheet<DateTime>(
      context: context,
      useRootNavigator: useRootNavigator,
      child: Builder(
        builder: (sheetContext) {
          return SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BottomSheetSlideBar(),
                SizedBox(
                  height: 220,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selected,
                    minimumDate: minimumDate,
                    maximumDate: maximumDate,
                    onDateTimeChanged: (value) => selected = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          child: Text(l10n.promptCancel),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FilledButton(
                          onPressed: () => Navigator.of(sheetContext).pop(selected),
                          child: Text(l10n.promptConform),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 指定日期范围：起始 / 截止 + 取消 / 确定
  static Future<({DateTime start, DateTime end})?> showDateRange(
    BuildContext context, {
    DateTime? initialStart,
    DateTime? initialEnd,
  }) {
    return BottomSheets.showCustomBottomSheet<({DateTime start, DateTime end})>(
      context: context,
      useRootNavigator: true,
      child: _DateRangeSheet(
        initialStart: initialStart,
        initialEnd: initialEnd,
      ),
    );
  }

  static DateTime _clampInitial(
    DateTime value, {
    DateTime? minimumDate,
    DateTime? maximumDate,
  }) {
    var result = value;
    if (minimumDate != null && result.isBefore(minimumDate)) result = minimumDate;
    if (maximumDate != null && result.isAfter(maximumDate)) result = maximumDate;
    return result;
  }
}

class _DateRangeSheet extends StatefulWidget {
  const _DateRangeSheet({
    this.initialStart,
    this.initialEnd,
  });

  final DateTime? initialStart;
  final DateTime? initialEnd;

  @override
  State<_DateRangeSheet> createState() => _DateRangeSheetState();
}

class _DateRangeSheetState extends State<_DateRangeSheet> {
  late DateTime? _start = widget.initialStart;
  late DateTime? _end = widget.initialEnd;

  bool get _canConfirm => _start != null && _end != null && !_start!.isAfter(_end!);

  Future<void> _pickStart() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final picked = await DatePickerSheets.showDatePicker(
      context,
      initialDateTime: _start ?? today,
      maximumDate: _end ?? today,
      useRootNavigator: true,
    );
    if (picked != null && mounted) {
      setState(() => _start = DateTime(picked.year, picked.month, picked.day));
    }
  }

  Future<void> _pickEnd() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final picked = await DatePickerSheets.showDatePicker(
      context,
      initialDateTime: _end ?? _start ?? today,
      minimumDate: _start,
      maximumDate: today,
      useRootNavigator: true,
    );
    if (picked != null && mounted) {
      setState(() => _end = DateTime(picked.year, picked.month, picked.day));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = LocalizationIntl.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BottomSheetSlideBar(),
            const SizedBox(height: 8),
            _DateFieldTile(
              label: l10n.searchStartDate,
              valueText: _start != null ? DatePickerSheets.formatDateValue(_start!) : l10n.pleaseSelectDate,
              placeholder: _start == null,
              onTap: _pickStart,
            ),
            const SizedBox(height: 12),
            _DateFieldTile(
              label: l10n.searchEndDate,
              valueText: _end != null ? DatePickerSheets.formatDateValue(_end!) : l10n.pleaseSelectDate,
              placeholder: _end == null,
              onTap: _pickEnd,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.promptCancel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _canConfirm
                        ? () => Navigator.of(context).pop((start: _start!, end: _end!))
                        : null,
                    child: Text(l10n.promptConform),
                  ),
                ),
              ],
            ),
            if (_start != null && _end != null && _start!.isAfter(_end!))
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  l10n.searchDateRangeInvalid,
                  style: TextStyle(fontSize: 12, color: colorScheme.error),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DateFieldTile extends StatelessWidget {
  const _DateFieldTile({
    required this.label,
    required this.valueText,
    required this.placeholder,
    required this.onTap,
  });

  final String label;
  final String valueText;
  final bool placeholder;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      valueText,
                      style: TextStyle(
                        fontSize: 16,
                        color: placeholder ? colorScheme.onSurfaceVariant : colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.calendar_today_outlined, size: 18, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
