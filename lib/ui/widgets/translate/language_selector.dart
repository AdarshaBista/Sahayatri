import 'package:flutter/material.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector();

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      radius: 0.0,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('ENGLISH', style: AppTextStyles.small.bold),
          const Icon(
            Icons.arrow_right_alt,
            color: AppColors.primaryDark,
          ),
          Text('NEPALI', style: AppTextStyles.small.bold),
        ],
      ),
    );
  }
}
