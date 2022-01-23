import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';

class CustomFormField<T> extends StatelessWidget {
  final T? initialValue;
  final FormFieldBuilder<T> builder;
  final FormFieldValidator<T> validator;

  const CustomFormField({
    required this.builder,
    required this.validator,
    required this.initialValue,
  });
  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      validator: validator,
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            builder(field),
            if (field.hasError) _buildError(field.errorText!),
          ],
        );
      },
    );
  }

  Padding _buildError(String message) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
      child: SlideAnimator(
        begin: const Offset(0.0, -1.0),
        child: Text(
          message,
          style: AppTextStyles.headline6.secondary,
        ),
      ),
    );
  }
}
