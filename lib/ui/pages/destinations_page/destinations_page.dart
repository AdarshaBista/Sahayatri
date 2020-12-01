import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/images.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/destinations_cubit/destinations_cubit.dart';

import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/destinations/destinations_list.dart';
import 'package:sahayatri/ui/pages/destinations_page/widgets/destinations_header.dart';

class DestinationsPage extends StatelessWidget {
  const DestinationsPage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const DestinationsHeader(),
        body: RefreshIndicator(
          onRefresh: () => context.read<DestinationsCubit>().fetchDestinations(),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            children: [_buildDestinationsState()],
          ),
        ),
      ),
    );
  }

  Widget _buildDestinationsState() {
    return BlocBuilder<DestinationsCubit, DestinationsState>(
      builder: (context, state) {
        if (state is DestinationsError) {
          return ErrorIndicator(
            imageUrl: Images.destinationsError,
            message: state.message,
            onRetry: () => context.read<DestinationsCubit>().fetchDestinations(),
          );
        } else if (state is DestinationsLoading) {
          return const BusyIndicator(imageUrl: Images.destinationsLoading);
        } else if (state is DestinationsLoaded) {
          return DestinationsList(
            isSearching: state.isSearching,
            destinations: state.destinations,
          );
        } else {
          return const EmptyIndicator(
            imageUrl: Images.destinationsEmpty,
            message: 'No destinations found.',
          );
        }
      },
    );
  }
}
