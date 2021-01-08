import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_update_form_cubit/destination_update_form_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/form/custom_text_field.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/tag_chip.dart';

class TagsField extends StatefulWidget {
  const TagsField();

  @override
  _TagsFieldState createState() => _TagsFieldState();
}

class _TagsFieldState extends State<TagsField> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DestinationUpdateFormCubit, DestinationUpdateFormState>(
      buildWhen: (p, c) => p.tags.length != c.tags.length,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(state.tags.length),
            if (state.tags.isNotEmpty) ...[
              if (state.tags.length < ApiConfig.maxImages) const SizedBox(height: 12.0),
              _buildTagsList(state.tags),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTextField(int tagsLength) {
    return CustomTextField(
      label: 'Tags',
      icon: AppIcons.tag,
      onChanged: addTag,
      hintText: 'Add a tag',
      controller: controller,
      validator: (_) => null,
      showField: tagsLength < ApiConfig.maxTags,
      middleChild: _buildLimitIndicator(tagsLength),
    );
  }

  Widget _buildLimitIndicator(int tagsLength) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 6.0),
      child: Text(
        '$tagsLength / ${ApiConfig.maxTags} tags',
        style: tagsLength == ApiConfig.maxTags
            ? AppTextStyles.headline6.secondary
            : AppTextStyles.headline6.primaryDark,
      ),
    );
  }

  Widget _buildTagsList(List<String> tags) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: tags
          .map((t) => TagChip(
                key: ValueKey(t),
                label: t,
                onDelete: (tag) =>
                    context.read<DestinationUpdateFormCubit>().removeTag(tag),
              ))
          .toList(),
    );
  }

  void addTag(String tag) {
    if (tag.trim().isEmpty) return;

    if (tag.endsWith(' ')) {
      context.read<DestinationUpdateFormCubit>().addTag(tag.trim());
      controller.clear();
    }
  }
}
