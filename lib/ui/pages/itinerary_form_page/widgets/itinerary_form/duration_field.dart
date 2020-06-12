import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_text_field.dart';

class DurationField extends StatelessWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const DurationField({
    @required this.label,
    @required this.onChanged,
    @required this.initialValue,
  })  : assert(label != null),
        assert(onChanged != null),
        assert(initialValue != null);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: label,
      initialValue: initialValue,
      labelStyle: AppTextStyles.small,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(),
    );
  }
}
