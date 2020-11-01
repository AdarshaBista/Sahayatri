import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/form/custom_text_field.dart';

class DurationField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const DurationField({
    @required this.icon,
    @required this.label,
    @required this.onChanged,
    @required this.initialValue,
  })  : assert(icon != null),
        assert(label != null),
        assert(onChanged != null),
        assert(initialValue != null);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      icon: icon,
      label: label,
      initialValue: initialValue,
      labelStyle: AppTextStyles.extraSmall,
      onChanged: onChanged,
      validator: FormValidators.duration('Please enter number of ${label.toLowerCase()}'),
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: [
        LengthLimitingTextInputFormatter(3),
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
    );
  }
}
