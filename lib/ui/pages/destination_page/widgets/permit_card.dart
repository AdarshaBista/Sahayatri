import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class PermitCard extends StatelessWidget {
  const PermitCard();

  @override
  Widget build(BuildContext context) {
    final permit =
        context.select<DestinationCubit, String>((dc) => dc.destination.permit);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Permits',
            style: AppTextStyles.headline4.bold,
          ),
          const SizedBox(height: 8.0),
          Text(
            permit,
            style: AppTextStyles.headline5,
          ),
        ],
      ),
    );
  }
}
