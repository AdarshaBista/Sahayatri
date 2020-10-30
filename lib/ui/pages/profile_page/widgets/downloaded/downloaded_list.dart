import 'package:flutter/material.dart';

import 'package:sahayatri/core/extensions/widget_x.dart';

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
              message: state.message,
              onRetry: context.bloc<DownloadedDestinationsCubit>().fetchDownloaded,
            );
          } else if (state is DownloadedDestinationsLoading) {
            return const BusyIndicator();
          } else if (state is DownloadedDestinationsLoaded) {
            return DestinationsList(
              deletable: true,
              destinations: state.destinations,
            );
          } else {
            return EmptyIndicator(
              message: 'No downloaded destinations!',
              onRetry: context.bloc<DownloadedDestinationsCubit>().fetchDownloaded,
            );
          }
        },
      ),
    );
  }
}
