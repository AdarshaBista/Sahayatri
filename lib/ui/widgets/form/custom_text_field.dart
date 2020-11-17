import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Color color;
  final bool isLarge;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final String initialValue;
  final TextStyle labelStyle;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter> inputFormatters;

  const CustomTextField({
    @required this.label,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.icon,
    this.hintText,
    this.labelStyle,
    this.controller,
    this.inputFormatters,
    this.isLarge = false,
    this.obscureText = false,
    this.color = AppColors.lightAccent,
    this.keyboardType = TextInputType.text,
  }) : assert(label != null);

  @override
  Widget build(BuildContext context) {
    final int maxLines = obscureText ? 1 : null;
    final int minLines = maxLines ?? (isLarge ? 4 : 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          validator: validator,
          onChanged: onChanged,
          initialValue: initialValue,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: AppTextStyles.small,
          inputFormatters: inputFormatters,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            fillColor: color,
            hintText: hintText,
            prefixIconConstraints: const BoxConstraints(
              minHeight: 32.0,
              minWidth: 32.0,
            ),
            prefixIcon: icon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Icon(icon, size: 20.0, color: AppColors.barrier),
                  ),
          ),
        ),
      ],
    );
  }
}
