import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/extensions/flushbar_extension.dart';
import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/buttons/save_button.dart';
import 'package:sahayatri/ui/widgets/forms/custom_text_field.dart';

class DeviceNameField extends StatefulWidget {
  const DeviceNameField({super.key});

  @override
  State<DeviceNameField> createState() => _DeviceNameFieldState();
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
        deviceName = state.prefs.deviceName;

        return CustomTextField(
          icon: AppIcons.nearbyDevice,
          label: 'Device name',
          onChanged: (value) => deviceName = value,
          validator: FormValidators.requiredText().call,
          initialValue: state.prefs.deviceName,
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
        if (!(_formKey.currentState?.validate() ?? false)) return;
        context.read<PrefsCubit>().saveDeviceName(deviceName);
        context.openFlushBar(
          'Device name saved: $deviceName',
          type: FlushbarType.success,
        );
      },
    );
  }
}
