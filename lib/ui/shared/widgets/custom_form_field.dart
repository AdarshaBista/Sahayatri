import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';

class CustomFormField<T> extends StatelessWidget {
  final T initialValue;
  final FormFieldBuilder<T> builder;
  final FormFieldValidator<T> validator;

  const CustomFormField({
    @required this.builder,
    @required this.validator,
    @required this.initialValue,
  })  : assert(builder != null),
        assert(validator != null);

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      initialValue: initialValue,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            builder(field),
            if (field.hasError) _buildError(field),
          ],
        );
      },
    );
  }

  Padding _buildError(FormFieldState field) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: SlideAnimator(
        begin: const Offset(0.0, -1.0),
        child: Text(
          field.errorText,
          style: AppTextStyles.extraSmall.secondary,
        ),
      ),
    );
  }
}
