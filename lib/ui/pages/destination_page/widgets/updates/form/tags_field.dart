import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/pages/destination_page/widgets/updates/tag_chip.dart';

class TagsField extends StatelessWidget {
  List<String> get tags => ['fun', 'alert', 'disaster', 'danger', 'general'];
  final List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
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
              .map((t) => TagChip(
                  label: t,
                  onSelect: (value) {
                    if (selectedTags.contains(value)) {
                      selectedTags.remove(value);
                    } else {
                      selectedTags.add(value);
                    }
                  }))
              .toList(),
        ),
      ],
    );
  }
}
