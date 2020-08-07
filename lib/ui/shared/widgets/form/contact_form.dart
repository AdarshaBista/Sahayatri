import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/widgets/form/custom_text_field.dart';

class ContactForm extends StatefulWidget {
  final bool isOnSettings;

  const ContactForm({
    @required this.isOnSettings,
  }) : assert(isOnSettings != null);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String contact = '';

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.decelerate,
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 200),
      child: FadeAnimator(
        child: SlideAnimator(
          begin: const Offset(0.0, 1.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact',
                  style: AppTextStyles.medium.bold,
                ),
                const SizedBox(height: 10.0),
                _buildTextField(),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildSubmitButton(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return BlocBuilder<PrefsBloc, PrefsState>(builder: (context, state) {
      return CustomTextField(
        iconGap: 16.0,
        icon: Icons.phone,
        label: 'Phone number',
        labelStyle: AppTextStyles.small.bold,
        validator: FormValidators.phoneNumber(),
        onChanged: (value) => contact = value,
        initialValue: (state as PrefsLoaded).prefs.contact,
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
      );
    });
  }

  Widget _buildSubmitButton(BuildContext context) {
    return FlatButton(
      child: Text(
        'SAVE',
        style: AppTextStyles.small.primary.bold,
      ),
      onPressed: () {
        if (!_formKey.currentState.validate()) return;
        context.bloc<PrefsBloc>().saveContact(contact);

        if (widget.isOnSettings) {
          Navigator.of(context).pop();
        } else {
          _showSavedSnackBar(context);
        }
      },
    );
  }

  void _showSavedSnackBar(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Contact saved: $contact',
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
