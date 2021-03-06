import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/utils/form_validators.dart';
import 'package:sahayatri/core/extensions/dialog_extension.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/mini_fab.dart';
import 'package:sahayatri/ui/widgets/common/sheet_header.dart';
import 'package:sahayatri/ui/widgets/dialogs/unsaved_dialog.dart';
import 'package:sahayatri/ui/widgets/forms/custom_text_field.dart';
import 'package:sahayatri/ui/widgets/common/star_rating_bar.dart';

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
    return WillPopScope(
      onWillPop: () => _handleBackButton(context),
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          children: [
            SheetHeader(
              title: 'Write a review',
              onClose: () async {
                if (await _handleBackButton(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
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
          style: context.t.headline5.bold,
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            StarRatingBar(
              size: 32.0,
              rating: rating,
              onUpdate: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            const Spacer(),
            const SizedBox(width: 12.0),
            Text(
              rating.toStringAsFixed(1),
              style: context.t.headline3,
            ),
            const SizedBox(width: 12.0),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTextField(
          isLarge: true,
          label: 'Review',
          initialValue: text,
          onChanged: (value) => setState(() => text = value),
          validator: FormValidators.requiredText(),
          inputFormatters: [
            LengthLimitingTextInputFormatter(ApiConfig.maxTextLength),
          ],
        ),
        const SizedBox(height: 6.0),
        Padding(
          padding: const EdgeInsets.only(right: 4.0),
          child: Text(
            '${text.length} / ${ApiConfig.maxTextLength}',
            style: context.t.headline6,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return MiniFab(
      onTap: () {
        if (!formKey.currentState.validate()) return;

        widget.onSubmit(rating, text);
        Navigator.of(context).pop();
      },
    );
  }

  Future<bool> _handleBackButton(BuildContext context) async {
    if (text.isNotEmpty) {
      const UnsavedDialog().openDialog(context);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
