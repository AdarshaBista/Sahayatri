import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class PermitCard extends StatelessWidget {
  const PermitCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Permits',
          style: context.t.headline5.bold,
        ),
        const SizedBox(height: 8.0),
        BlocBuilder<DestinationCubit, Destination>(
          builder: (context, destination) {
            return Text(
              destination.permit,
              style: context.t.headline5,
            );
          },
        ),
      ],
    );
  }
}
