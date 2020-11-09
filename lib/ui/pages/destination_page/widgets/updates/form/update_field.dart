import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/form/custom_text_field.dart';

class UpdateField extends StatelessWidget {
  const UpdateField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextField(
              isLarge: true,
              label: 'Write something',
              initialValue: state.text,
              validator: FormValidators.requiredText(),
              inputFormatters: [
                LengthLimitingTextInputFormatter(ApiConfig.maxTextLength),
              ],
              onChanged: (value) =>
                  context.read<DestinationUpdateFormCubit>().changeText(value),
            ),
            const SizedBox(height: 6.0),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(
                '${state.text.length} / ${ApiConfig.maxTextLength}',
                style: AppTextStyles.extraSmall,
              ),
            ),
          ],
        );
      },
    );
  }
}
