import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/styles/styles.dart';

class PermitCard extends StatelessWidget {
  const PermitCard();

  @override
  Widget build(BuildContext context) {
    final permit = context.bloc<DestinationBloc>().destination.permit;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Permits',
            style: AppTextStyles.medium.bold,
          ),
          const SizedBox(height: 8.0),
          Text(
            permit,
            style: AppTextStyles.small,
          ),
        ],
      ),
    );
  }
}
