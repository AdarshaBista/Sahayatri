import 'package:flutter/material.dart';

import 'package:sahayatri/app/database/destination_dao.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/downloaded_destinations_cubit/downloaded_destinations_cubit.dart';

import 'package:sahayatri/ui/shared/widgets/header.dart';
import 'package:sahayatri/ui/shared/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';
import 'package:sahayatri/ui/shared/destinations/destinations_list.dart';

class DownloadedList extends StatelessWidget {
  const DownloadedList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DownloadedDestinationsCubit>(
      create: (context) => DownloadedDestinationsCubit(
        destinationDao: context.repository<DestinationDao>(),
      )..getDestinations(),
      child: Builder(
        builder: (context) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const Header(leftPadding: 12.0, boldTitle: 'Downloaded'),
              const SizedBox(height: 8.0),
              _buildList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList() {
    return BlocBuilder<DownloadedDestinationsCubit, DownloadedDestinationsState>(
      builder: (context, state) {
        if (state is DownloadedDestinationsError) {
          return ErrorIndicator(
            message: state.message,
            onRetry: context.bloc<DownloadedDestinationsCubit>().getDestinations,
          );
        } else if (state is DownloadedDestinationsLoading) {
          return const BusyIndicator();
        } else if (state is DownloadedDestinationsLoaded) {
          return DestinationsList(destinations: state.destinations);
        } else {
          return EmptyIndicator(
            message: 'No downloaded destinations!',
            onRetry: context.bloc<DownloadedDestinationsCubit>().getDestinations,
          );
        }
      },
    );
  }
}
