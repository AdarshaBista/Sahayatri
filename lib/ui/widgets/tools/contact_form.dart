import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/extensions/flushbar_extension.dart';
import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/fade_animator.dart';
import 'package:sahayatri/ui/widgets/animators/slide_animator.dart';
import 'package:sahayatri/ui/widgets/buttons/save_button.dart';
import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/forms/custom_text_field.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String contact = '';

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: SlideAnimator(
        begin: const Offset(0.0, 1.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(
                title: 'Assign a contact',
                fontSize: 20.0,
              ),
              const SizedBox(height: 6.0),
              Text(
                'A message will be automatically sent to this number once you reach a checkpoint.',
                style: context.t.titleLarge,
              ),
              const SizedBox(height: 12.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: _buildTextField()),
                  const SizedBox(width: 8.0),
                  _buildSubmitButton(context),
                ],
              ),
              const SizedBox(height: 16.0),
              _buildPreviewText(),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return BlocBuilder<PrefsCubit, PrefsState>(builder: (context, state) {
      contact = state.prefs.contact;

      return CustomTextField(
        label: 'Phone number',
        icon: AppIcons.phone,
        validator: FormValidators.phoneNumber(),
        onChanged: (value) => contact = value,
        initialValue: state.prefs.contact,
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
      );
    });
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SaveButton(
      onPressed: () {
        if (!(_formKey.currentState?.validate() ?? false)) return;
        context.read<PrefsCubit>().saveContact(contact);

        Navigator.of(context).pop();
        context.openFlushBar('Contact saved: $contact', type: FlushbarType.success);
      },
    );
  }

  Widget _buildPreviewText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Message Preview',
          textAlign: TextAlign.left,
          style: context.t.headlineSmall?.bold,
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            'I have safely reached ...',
            style: AppTextStyles.headline6.light,
          ),
        ),
      ],
    );
  }
}
