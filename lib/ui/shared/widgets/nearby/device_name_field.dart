import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/widgets/form/custom_text_field.dart';

class DeviceNameField extends StatefulWidget {
  const DeviceNameField();

  @override
  _DeviceNameFieldState createState() => _DeviceNameFieldState();
}

class _DeviceNameFieldState extends State<DeviceNameField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String deviceName = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildTextField(),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return BlocBuilder<PrefsCubit, PrefsState>(
      builder: (context, state) {
        deviceName = (state as PrefsLoaded).prefs.deviceName;

        return CustomTextField(
          iconGap: 16.0,
          icon: Icons.account_box,
          label: 'Device name',
          onChanged: (value) => deviceName = value,
          validator: FormValidators.requiredText(),
          initialValue: (state as PrefsLoaded).prefs.deviceName,
          inputFormatters: [
            LengthLimitingTextInputFormatter(16),
            FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
          ],
        );
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return FlatButton(
      child: Text(
        'SAVE',
        style: AppTextStyles.small.primary.bold,
      ),
      onPressed: () {
        if (!_formKey.currentState.validate()) return;
        context.bloc<PrefsCubit>().saveDeviceName(deviceName);
        _showSavedSnackBar(context);
      },
    );
  }

  void _showSavedSnackBar(BuildContext context) {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Device name saved: $deviceName',
            style: AppTextStyles.small.light,
          ),
        ),
      );
  }
}
