import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';
import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/shared/buttons/save_button.dart';
import 'package:sahayatri/ui/shared/form/custom_text_field.dart';

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: _buildTextField()),
          const SizedBox(width: 8.0),
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
    return SaveButton(
      onPressed: () {
        if (!_formKey.currentState.validate()) return;
        context.bloc<PrefsCubit>().saveDeviceName(deviceName);
        context.openSnackBar('Device name saved: $deviceName');
      },
    );
  }
}
