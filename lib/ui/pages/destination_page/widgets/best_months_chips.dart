import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/ui/pages/destination_page/widgets/tag_chip.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class BestMonthsChips extends StatelessWidget {
  const BestMonthsChips({super.key});

  @override
  Widget build(BuildContext context) {
    final destination = context.watch<Destination>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Best Months',
          style: context.t.headlineSmall?.bold,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: destination.bestMonths
              .map((m) => ScaleAnimator(
                    child: TagChip(label: m),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
