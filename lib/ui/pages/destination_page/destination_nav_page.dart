import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/routers/destination_router.dart';

import 'package:sahayatri/cubits/download_cubit/download_cubit.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/user_itinerary_cubit/user_itinerary_cubit.dart';

import 'package:sahayatri/locator.dart';

class DestinationNavPage extends StatelessWidget {
  const DestinationNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return _buildPage();
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider<DownloadCubit>(
              create: (context) => DownloadCubit(
                user: context.read<UserCubit>().user!,
                destination: context.read<Destination>(),
              )..checkDownloaded(),
            ),
            BlocProvider<PlacesCubit>(
              lazy: false,
              create: (context) => PlacesCubit(
                user: context.read<UserCubit>().user!,
                destination: context.read<Destination>(),
              )..fetchPlaces(),
            ),
            BlocProvider<UserItineraryCubit>(
              create: (context) => UserItineraryCubit(
                destination: context.read<Destination>(),
              )..getItinerary(),
            ),
          ],
          child: _buildPage(),
        );
      },
    );
  }

  Widget _buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (!locator<DestinationNavService>().canPop()) return true;
        locator<DestinationNavService>().pop();
        return false;
      },
      child: Navigator(
        key: locator<DestinationNavService>().navigatorKey,
        observers: [HeroController()],
        onGenerateRoute: DestinationRouter.onGenerateRoute,
      ),
    );
  }
}
