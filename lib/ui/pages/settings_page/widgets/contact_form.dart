import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/prefs_bloc/prefs_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/custom_text_field.dart';

class ContactForm extends StatefulWidget {
  const ContactForm();

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  String contact = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 12.0,
      clipBehavior: Clip.antiAlias,
      titlePadding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      backgroundColor: AppColors.light,
      title: _buildTextField(),
      actions: [_buildSubmitButton(context)],
    );
  }

  Widget _buildTextField() {
    return BlocBuilder<PrefsBloc, PrefsState>(builder: (context, state) {
      return CustomTextField(
        label: 'Contact number',
        icon: Icons.phone,
        iconGap: 16.0,
        onChanged: (value) => contact = value,
        initialValue: (state as PrefsLoaded).prefs.contact,
        keyboardType: const TextInputType.numberWithOptions(),
      );
    });
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FlatButton(
        child: Text(
          'SAVE',
          style: AppTextStyles.small.primary.bold,
        ),
        onPressed: () {
          context.bloc<PrefsBloc>().add(ContactSaved(contact: contact));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
