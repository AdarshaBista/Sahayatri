import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/custom_text_field.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';

class ReviewForm extends StatefulWidget {
  final VoidCallback onSubmit;

  const ReviewForm({
    @required this.onSubmit,
  }) : assert(onSubmit != null);

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  double rating = 3.0;
  String text = '';

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          children: [
            Text(
              'Write a Review',
              style: AppTextStyles.medium.bold,
            ),
            const Divider(height: 16.0),
            _buildRatingField(),
            const SizedBox(height: 16.0),
            _buildTextField(),
            const SizedBox(height: 16.0),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingField() {
    return StarRatingBar(
      rating: rating,
      onUpdate: (value) {
        setState(() {
          rating = value;
        });
      },
    );
  }

  Widget _buildTextField() {
    return CustomTextField(
      label: 'Review',
      initialValue: text,
      onChanged: (value) => text = value,
      validator: FormValidators.requiredText(),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: AppColors.dark,
      child: const Icon(
        Icons.check,
        size: 24.0,
        color: AppColors.primary,
      ),
      onPressed: () {
        if (!formKey.currentState.validate()) return;

        widget.onSubmit();
        Navigator.of(context).pop();
      },
    );
  }
}
