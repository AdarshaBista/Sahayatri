import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/translation.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/elevated_card.dart';

class TranslateBubble extends StatelessWidget {
  final Translation translation;

  const TranslateBubble({
    @required this.translation,
  }) : assert(translation != null);

  @override
  Widget build(BuildContext context) {
    const double radius = 16.0;
    final isQuery = translation.isQuery;

    return Container(
      alignment: isQuery ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
        left: isQuery ? 50.0 : 0.0,
        right: isQuery ? 0.0 : 50.0,
      ),
      child: ElevatedCard(
        color: isQuery ? AppColors.primaryDark : AppColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isQuery ? radius : 0.0),
          topRight: Radius.circular(isQuery ? 0.0 : radius),
          bottomLeft: Radius.circular(isQuery ? radius : 0.0),
          bottomRight: Radius.circular(isQuery ? 0.0 : radius),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: _buildText(),
        ),
      ),
    );
  }

  Widget _buildText() {
    final isQuery = translation.isQuery;

    return Column(
      crossAxisAlignment: isQuery ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (translation.language != null) ...[
          Text(
            translation.language,
            style: isQuery
                ? AppTextStyles.extraSmall.lightAccent
                : AppTextStyles.extraSmall.darkAccent,
          ),
          const SizedBox(height: 4.0),
        ],
        Text(
          translation.text,
          style: isQuery
              ? AppTextStyles.small.light
              : translation.language != null
                  ? AppTextStyles.small.dark
                  : AppTextStyles.small.secondary,
        ),
      ],
    );
  }
}
