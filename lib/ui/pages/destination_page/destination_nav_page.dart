import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/destinations_service.dart';

import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/routers/destination_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';
import 'package:sahayatri/cubits/download_cubit/download_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

class DestinationNavPage extends StatelessWidget {
  const DestinationNavPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return _buildPage(context);
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider<DownloadCubit>(
              create: (context) => DownloadCubit(
                user: context.read<UserCubit>().user,
                destination: context.read<Destination>(),
                destinationsService: context.read<DestinationsService>(),
              )..checkDownloaded(),
            ),
            BlocProvider<PlacesCubit>(
              create: (context) => PlacesCubit(
                user: context.read<UserCubit>().user,
                apiService: context.read<ApiService>(),
                destination: context.read<Destination>(),
              )..fetchPlaces(),
            ),
            BlocProvider<UserItineraryCubit>(
              create: (context) => UserItineraryCubit(
                destination: context.read<Destination>(),
                itineraryDao: context.read<ItineraryDao>(),
              )..getItinerary(),
            ),
          ],
          child: _buildPage(context),
        );
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!context.read<DestinationNavService>().canPop()) return true;
        context.read<DestinationNavService>().pop();
        return false;
      },
      child: Navigator(
        key: RepositoryProvider.of<DestinationNavService>(context).navigatorKey,
        observers: [HeroController()],
        onGenerateRoute: DestinationRouter.onGenerateRoute,
      ),
    );
  }
}
