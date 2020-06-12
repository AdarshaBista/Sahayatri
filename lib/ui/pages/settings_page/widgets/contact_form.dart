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
    return BlocBuilder<PrefsBloc, PrefsState>(
      builder: (context, state) {
        return AlertDialog(
          elevation: 12.0,
          clipBehavior: Clip.antiAlias,
          titlePadding: const EdgeInsets.all(20.0),
          backgroundColor: AppColors.background,
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(state.prefs.contact),
              const SizedBox(height: 12.0),
              _buildSubmitButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(String intialValue) {
    return CustomTextField(
      label: 'Contact',
      onChanged: (value) => contact = value,
      initialValue: intialValue,
      keyboardType: const TextInputType.numberWithOptions(),
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
        context.bloc<PrefsBloc>().add(
              ContactSaved(contact: contact),
            );
        Navigator.of(context).pop();
      },
    );
  }
}
