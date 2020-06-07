import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/shared/animators/scale_animator.dart';

class BestMonthsChips extends StatelessWidget {
  const BestMonthsChips();

  @override
  Widget build(BuildContext context) {
    final bestMonths = context.bloc<DestinationBloc>().destination.bestMonths;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Best Months',
            style: AppTextStyles.medium.bold,
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            children: bestMonths
                .map(
                  (m) => ScaleAnimator(
                    child: Chip(
                      backgroundColor: AppColors.light,
                      visualDensity: VisualDensity.compact,
                      label: Text(
                        m,
                        style: AppTextStyles.extraSmall,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
