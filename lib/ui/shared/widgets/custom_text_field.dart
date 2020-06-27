import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final double iconGap;
  final String initialValue;
  final TextStyle labelStyle;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  const CustomTextField({
    @required this.label,
    @required this.onChanged,
    @required this.initialValue,
    this.icon,
    this.iconGap = 32.0,
    this.labelStyle,
    this.keyboardType = TextInputType.text,
  })  : assert(label != null),
        assert(onChanged != null),
        assert(initialValue != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? AppTextStyles.medium,
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          onChanged: onChanged,
          maxLines: null,
          decoration: icon != null
              ? InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.0, right: iconGap),
                    child: Icon(
                      icon,
                      size: 22.0,
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
