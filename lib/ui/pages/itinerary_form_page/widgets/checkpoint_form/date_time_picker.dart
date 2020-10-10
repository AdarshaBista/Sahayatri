import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/custom_card.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime initialDateTime;
  final Function(DateTime) onSelect;

  const DateTimePicker({
    @required this.onSelect,
    @required this.initialDateTime,
  }) : assert(onSelect != null);

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date & Time',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
        CustomCard(
          child: ListTile(
            dense: true,
            title: Text(
              selectedDateTime == null
                  ? 'No date & time selected'
                  : _formattedDate(selectedDateTime),
              style: AppTextStyles.small,
            ),
            leading: const Icon(
              Icons.date_range,
              size: 22.0,
            ),
            onTap: () async {
              FocusScope.of(context).unfocus();
              _selectDateTime();
            },
          ),
        ),
      ],
    );
  }

  Future<void> _selectDateTime() async {
    final DateTime pickedDate = await _showDatePicker(context);
    if (pickedDate == null) return;

    final DateTime pickedTime = await _showTimePicker(context);
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
    widget.onSelect(selectedDateTime);
  }

  Future<DateTime> _showDatePicker(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      theme: _dateTimePickerTheme,
      currentTime: selectedDateTime ?? DateTime.now(),
      minTime: DateTime.now(),
      maxTime: DateTime.now().add(const Duration(days: 5 * 365)),
    );
  }

  Future<DateTime> _showTimePicker(BuildContext context) {
    return DatePicker.showTime12hPicker(
      context,
      theme: _dateTimePickerTheme,
      currentTime: selectedDateTime ?? DateTime.now(),
    );
  }

  DatePickerTheme get _dateTimePickerTheme => DatePickerTheme(
        itemStyle: AppTextStyles.medium,
        doneStyle: AppTextStyles.small.primary,
        cancelStyle: AppTextStyles.small.secondary,
      );

  String _formattedDate(DateTime date) {
    return DateFormat('MMM dd y h:mm a').format(date);
  }
}
