import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/directions_bloc/directions_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';
import 'package:sahayatri/blocs/destinations_bloc/destinations_bloc.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';

import 'package:sahayatri/ui/shared/animators/page_transition.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';

import 'package:sahayatri/ui/pages/bottom_nav_page/bottom_nav_page.dart';
import 'package:sahayatri/ui/pages/destination_page/destination_nav_page.dart';

class RootRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget _page;

    switch (settings.name) {
      case Routes.kBottomNavPageRoute:
        _page = BlocProvider<DestinationsBloc>(
          create: (context) => DestinationsBloc(
            apiService: context.repository<ApiService>(),
          )..add(DestinationsFetched()),
          child: const BottomNavPage(),
        );
        break;

      case Routes.kDestinationPageRoute:
        _page = MultiBlocProvider(
          providers: [
            BlocProvider<DestinationBloc>(
              create: (context) => DestinationBloc(
                destination: settings.arguments as Destination,
              ),
            ),
            BlocProvider<DirectionsBloc>(
              create: (context) => DirectionsBloc(
                directionsService: context.repository<DirectionsService>(),
              ),
            ),
          ],
          child: const DestinationNavPage(),
        );
        break;

      default:
        _page = Scaffold(
          appBar: AppBar(),
          body: Center(
            child: ErrorIndicator(
              message: 'No route defined for\n${settings.name}',
            ),
          ),
        );
        break;
    }

    return PageTransition(page: _page);
  }
}
