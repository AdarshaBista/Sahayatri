import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final double iconGap;
  final bool obscureText;
  final String initialValue;
  final TextStyle labelStyle;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;

  const CustomTextField({
    @required this.label,
    @required this.onChanged,
    @required this.validator,
    @required this.initialValue,
    this.icon,
    this.labelStyle,
    this.inputFormatters,
    this.iconGap = 32.0,
    this.obscureText = false,
    this.color = AppColors.lightAccent,
    this.keyboardType = TextInputType.text,
  })  : assert(label != null),
        assert(onChanged != null),
        assert(validator != null),
        assert(obscureText != null),
        assert(initialValue != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          maxLines: obscureText ? 1 : null,
          validator: validator,
          onChanged: onChanged,
          initialValue: initialValue,
          keyboardType: keyboardType,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            fillColor: color,
            prefixIcon: icon == null
                ? null
                : Padding(
                    padding: EdgeInsets.only(left: 16.0, right: iconGap),
                    child: Icon(
                      icon,
                      size: 22.0,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}