import 'package:flutter/material.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';
import 'package:sahayatri/ui/widgets/form/custom_text_field.dart';

class TranslateTextField extends StatefulWidget {
  const TranslateTextField();

  @override
  _TranslateTextFieldState createState() => _TranslateTextFieldState();
}

class _TranslateTextFieldState extends State<TranslateTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String source = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTextField(),
          const SizedBox(height: 12.0),
          _buildTranslateButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return ElevatedCard(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        validator: FormValidators.requiredText(),
        onChanged: (value) => source = value,
        initialValue: source,
        style: AppTextStyles.small,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: const InputDecoration(
          fillColor: Colors.transparent,
          hintText: 'Type Something...',
        ),
      ),
    );
  }

  Widget _buildTranslateButton(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: AppColors.dark,
      child: const Icon(
        Icons.arrow_downward,
        size: 24.0,
        color: AppColors.primary,
      ),
      onPressed: () {
        if (!_formKey.currentState.validate()) return;
        context.bloc<TranslateCubit>().translate(source);
      },
    );
  }
}
