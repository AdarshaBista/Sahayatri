import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/images.dart';
import 'package:sahayatri/core/extensions/index.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/downloaded_destinations_cubit/downloaded_destinations_cubit.dart';

import 'package:sahayatri/ui/widgets/common/header.dart';
import 'package:sahayatri/ui/widgets/destinations/destinations_list.dart';
import 'package:sahayatri/ui/widgets/indicators/busy_indicator.dart';
import 'package:sahayatri/ui/widgets/indicators/empty_indicator.dart';
import 'package:sahayatri/ui/widgets/common/unauthenticated_view.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

class DownloadedPage extends StatelessWidget {
  const DownloadedPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return _buildPage();
          }
          return const Center(child: UnauthenticatedView());
        },
      ),
    );
  }

  Widget _buildPage() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12.0),
          const Header(
            title: 'Downloaded',
            padding: 16.0,
            fontSize: 32.0,
          ),
          const SizedBox(height: 12.0),
          Expanded(child: _buildDownloadedState()),
        ],
      ),
    );
  }

  Widget _buildDownloadedState() {
    return BlocConsumer<DownloadedDestinationsCubit, DownloadedDestinationsState>(
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
            onRetry: () => context.read<DownloadedDestinationsCubit>().fetchDownloaded(),
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
            onRetry: () => context.read<DownloadedDestinationsCubit>().fetchDownloaded(),
          );
        }
      },
    );
  }
}
