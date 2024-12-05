import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/forms/custom_text_field.dart';

class DurationField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const DurationField({
    super.key,
    required this.icon,
    required this.label,
    required this.onChanged,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      icon: icon,
      label: label,
      initialValue: initialValue,
      labelStyle: context.t.titleLarge,
      onChanged: onChanged,
      validator: FormValidators.duration('Please enter number of ${label.toLowerCase()}').call,
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
    );
  }
}
