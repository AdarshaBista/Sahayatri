import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/index.dart';

import 'package:sahayatri/app/constants/configs.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/downloaded_destinations_cubit/downloaded_destinations_cubit.dart';

import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';
import 'package:sahayatri/ui/widgets/destinations/destinations_list.dart';

class DownloadedList extends StatelessWidget {
  const DownloadedList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<DownloadedDestinationsCubit, DownloadedDestinationsState>(
        listener: (context, state) {
          if (state is DownloadedDestinationsMessage) {
            context.openFlushBar(state.message);
          }
        },
        builder: (context, state) {
          if (state is DownloadedDestinationsError) {
            return ErrorIndicator(
              imageUrl: Images.destinationsError,
              message: state.message,
              onRetry: () =>
                  context.read<DownloadedDestinationsCubit>().fetchDownloaded(),
            );
          } else if (state is DownloadedDestinationsLoading) {
            return const BusyIndicator(imageUrl: Images.destinationsLoading);
          } else if (state is DownloadedDestinationsLoaded) {
            return DestinationsList(
              deletable: true,
              isSearching: false,
              destinations: state.destinations,
            );
          } else {
            return EmptyIndicator(
              imageUrl: Images.destinationsEmpty,
              message: 'No downloaded destinations!',
              onRetry: () =>
                  context.read<DownloadedDestinationsCubit>().fetchDownloaded(),
            );
          }
        },
      ),
    );
  }
}
