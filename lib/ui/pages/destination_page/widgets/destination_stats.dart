import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';

import 'package:sahayatri/ui/shared/widgets/stat_card.dart';

class DestinationStats extends StatelessWidget {
  const DestinationStats();

  @override
  Widget build(BuildContext context) {
    final destination = context.bloc<DestinationBloc>().destination;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          StatCard(
            label: 'Length',
            count: '${destination.length} km',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Duration',
            count: '${destination.estimatedDuration} days',
            color: Colors.teal,
          ),
          StatCard(
            label: 'Altitude',
            count: '${destination.maxAltitude} m',
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}
