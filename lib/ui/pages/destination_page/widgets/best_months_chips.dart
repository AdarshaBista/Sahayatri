import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/animators/scale_animator.dart';

class BestMonthsChips extends StatelessWidget {
  const BestMonthsChips();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Best Months',
          style: context.t.headline5.bold,
        ),
        const SizedBox(height: 8.0),
        BlocBuilder<DestinationCubit, Destination>(
          builder: (context, destination) {
            return Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: destination.bestMonths
                  .map((m) => ScaleAnimator(
                        child: Chip(
                          visualDensity: VisualDensity.compact,
                          label: Text(m, style: context.t.headline6),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
