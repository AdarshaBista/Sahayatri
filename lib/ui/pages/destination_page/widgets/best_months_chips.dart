import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class BestMonthsChips extends StatelessWidget {
  const BestMonthsChips();

  @override
  Widget build(BuildContext context) {
    final bestMonths = context.bloc<DestinationCubit>().destination.bestMonths;

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
            runSpacing: 8.0,
            children: bestMonths
                .map((m) => ScaleAnimator(
                      child: Chip(
                        backgroundColor: AppColors.lightAccent,
                        visualDensity: VisualDensity.compact,
                        label: Text(m, style: AppTextStyles.extraSmall),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
