import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isLarge;
  final bool showField;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? hintText;
  final Widget? middleChild;
  final String? initialValue;
  final TextStyle? labelStyle;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.label,
    this.isLarge = false,
    this.showField = true,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.icon,
    this.hintText,
    this.labelStyle,
    this.controller,
    this.middleChild,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(context),
        if (middleChild != null) middleChild!,
        if (showField) ...[
          if (middleChild == null) const SizedBox(height: 8.0),
          _buildField(context),
        ],
      ],
    );
  }

  Widget _buildLabel(BuildContext context) {
    return Text(
      label,
      style: labelStyle ?? context.t.headlineSmall?.bold,
    );
  }

  Widget _buildField(BuildContext context) {
    final int? maxLines = obscureText ? 1 : null;
    final int minLines = maxLines ?? (isLarge ? 4 : 1);

    return ScaleAnimator(
      duration: 200,
      child: TextFormField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        validator: validator,
        onChanged: onChanged,
        initialValue: initialValue,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: context.t.headlineSmall,
        inputFormatters: inputFormatters,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIconConstraints: const BoxConstraints(
            minHeight: 32.0,
            minWidth: 32.0,
          ),
          prefixIcon: icon == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Icon(icon, size: 20.0, color: context.c.onSurface),
                ),
        ),
      ),
    );
  }
}
