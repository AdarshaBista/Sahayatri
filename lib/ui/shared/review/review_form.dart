import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/custom_text_field.dart';
import 'package:sahayatri/ui/shared/widgets/star_rating_bar.dart';

class ReviewForm extends StatefulWidget {
  final void Function(double, String) onSubmit;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rating',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 12.0),
        StarRatingBar(
          rating: rating,
          onUpdate: (value) {
            setState(() {
              rating = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTextField() {
    const int kMaxLength = 500;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          label: 'Review',
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

        widget.onSubmit(rating, text);
        Navigator.of(context).pop();
      },
    );
  }
}
