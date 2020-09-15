import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sahayatri/core/utils/form_validators.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_post_cubit/destination_update_post_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/form/custom_text_field.dart';

class UpdateField extends StatelessWidget {
  static const int kMaxLength = 500;

  const UpdateField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdatePostCubit, DestinationUpdatePostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextField(
              label: 'Write something',
              initialValue: state.text,
              validator: FormValidators.requiredText(),
              inputFormatters: [LengthLimitingTextInputFormatter(kMaxLength)],
              onChanged: context.bloc<DestinationUpdatePostCubit>().changeText,
            ),
            const SizedBox(height: 6.0),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(
                '${state.text.length} / $kMaxLength',
                style: AppTextStyles.extraSmall,
              ),
            ),
          ],
        );
      },
    );
  }
}
