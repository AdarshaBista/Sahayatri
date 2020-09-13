import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/custom_text_field.dart';

class UpdateField extends StatefulWidget {
  const UpdateField();

  @override
  _UpdateFieldState createState() => _UpdateFieldState();
}

class _UpdateFieldState extends State<UpdateField> {
  static const int kMaxLength = 500;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          label: 'Write something',
          initialValue: text,
          onChanged: (value) => setState(() => text = value),
          validator: FormValidators.requiredText(),
          inputFormatters: [
            LengthLimitingTextInputFormatter(kMaxLength),
          ],
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            '${text.length} / $kMaxLength',
            style: AppTextStyles.extraSmall,
          ),
        ),
      ],
    );
  }
}
