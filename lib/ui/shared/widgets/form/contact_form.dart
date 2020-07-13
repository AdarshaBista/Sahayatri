import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/prefs_bloc/prefs_bloc.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/fade_animator.dart';
import 'package:sahayatri/ui/shared/animators/slide_animator.dart';
import 'package:sahayatri/ui/shared/widgets/form/custom_text_field.dart';

class ContactForm extends StatefulWidget {
  final bool shouldPop;

  const ContactForm({
    @required this.shouldPop,
  }) : assert(shouldPop != null);

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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildTextField(),
                _buildSubmitButton(context),
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
        label: 'Contact number',
        labelStyle: AppTextStyles.small.bold,
        validator: FormValidators.phoneNumber(),
        onChanged: (value) => contact = value,
        initialValue: (state as PrefsLoaded).prefs.contact,
        keyboardType: const TextInputType.numberWithOptions(),
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
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

        context.bloc<PrefsBloc>().add(ContactSaved(contact: contact));
        if (widget.shouldPop) {
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
            'Contact Saved: $contact',
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
