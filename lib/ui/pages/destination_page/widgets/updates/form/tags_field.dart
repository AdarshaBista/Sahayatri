import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/tag_chip.dart';

class TagsField extends StatelessWidget {
  List<String> get tags => ['fun', 'alert', 'disaster', 'danger', 'general'];

  @override
  Widget build(BuildContext context) {
    final updateCubit = context.bloc<DestinationUpdateFormCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tags',
          style: AppTextStyles.small.bold,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: tags
              .map((t) => TagChip(label: t, onSelect: updateCubit.updateTags))
              .toList(),
        ),
      ],
    );
  }
}
