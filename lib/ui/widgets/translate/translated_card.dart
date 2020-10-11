import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/translation.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class TranslatedCard extends StatelessWidget {
  final Translation translation;

  const TranslatedCard({
    @required this.translation,
  }) : assert(translation != null);

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      color: AppColors.primaryDark,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                translation.targetLang,
                style: AppTextStyles.small.lightAccent,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.volume_up_rounded,
                  size: 24.0,
                  color: AppColors.light,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            translation.text,
            style: AppTextStyles.medium.light,
          ),
        ],
      ),
    );
  }
}
