import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/widgets/checkpoint_form/custom_form_tile.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final void Function(DateTime) onSelect;

  const DateTimePicker({
    required this.onSelect,
    required this.initialDateTime,
  });

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return CustomFormTile(
      title: 'Date & Time',
      icon: AppIcons.date,
      hintText: selectedDateTime == null
          ? 'No date & time selected'
          : _formattedDate(selectedDateTime!),
      onTap: () {
        FocusScope.of(context).unfocus();
        _selectDateTime();
      },
    );
  }

  Future<void> _selectDateTime() async {
    final pickedDate = await _showDatePicker(context);
    if (pickedDate == null) return;

    final pickedTime = await _showTimePicker(context);
    if (pickedTime == null) return;

    setState(() {
      selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
    widget.onSelect(selectedDateTime!);
  }

  Future<DateTime?> _showDatePicker(BuildContext context) {
    final now = DateTime.now();
    final firstDate =
        (selectedDateTime == null || selectedDateTime!.isAfter(now))
            ? now
            : selectedDateTime;

    return showDatePicker(
      context: context,
      helpText: '',
      fieldLabelText: '',
      builder: _getTheme,
      firstDate: firstDate!,
      initialDate: selectedDateTime ?? now,
      lastDate: DateTime.now().add(const Duration(days: 5 * 365)),
    );
  }

  Future<TimeOfDay?> _showTimePicker(BuildContext context) {
    final initialTime = selectedDateTime == null
        ? TimeOfDay.now()
        : TimeOfDay(
            hour: selectedDateTime!.hour,
            minute: selectedDateTime!.minute,
          );

    return showTimePicker(
      context: context,
      helpText: '',
      builder: _getTheme,
      initialTime: initialTime,
    );
  }

  Widget _getTheme(BuildContext context, Widget? child) {
    final colorScheme = Theme.of(context).colorScheme;
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: TextTheme(subtitle1: context.t.headline5),
        colorScheme: colorScheme.copyWith(
          onPrimary: AppColors.light,
          primary: AppColors.primaryDark,
          surface: context.theme.cardColor,
        ),
      ),
      child: child!,
    );
  }

  String _formattedDate(DateTime date) {
    return DateFormat('MMM dd y, h:mm a').format(date);
  }
}
