import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class PermitCard extends StatelessWidget {
  const PermitCard({super.key});

  @override
  Widget build(BuildContext context) {
    final destination = context.watch<Destination>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Permits',
          style: context.t.headlineSmall?.bold,
        ),
        const SizedBox(height: 8.0),
        Text(
          destination.permit,
          style: context.t.headlineSmall,
        ),
      ],
    );
  }
}
