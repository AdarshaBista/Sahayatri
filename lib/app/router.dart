import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';
import 'package:sahayatri/blocs/directions_bloc/directions_bloc.dart';
import 'package:sahayatri/blocs/destination_bloc/destination_bloc.dart';
import 'package:sahayatri/blocs/destinations_bloc/destinations_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';

import 'package:sahayatri/ui/shared/animators/page_transition.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';

import 'package:sahayatri/ui/pages/route_page/route_page.dart';
import 'package:sahayatri/ui/pages/place_page/place_page.dart';
import 'package:sahayatri/ui/pages/tracker_page/tracker_page.dart';
import 'package:sahayatri/ui/pages/bottom_nav_page/bottom_nav_page.dart';
import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';
import 'package:sahayatri/ui/pages/destination_page/destination_page.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/itinerary_form_page.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/destination_detail_page.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget _page;

    switch (settings.name) {
      case Routes.kBottomNavPageRoute:
        _page = BlocProvider<DestinationsBloc>(
          create: (context) => DestinationsBloc(
            apiService: context.repository<ApiService>(),
          )..add(DestinationsFetched()),
          child: BottomNavPage(),
        );
        break;

      case Routes.kDestinationPageRoute:
        _page = MultiProvider(
          providers: [
            BlocProvider<DestinationBloc>(
              create: (context) => DestinationBloc(
                destination: settings.arguments as Destination,
              ),
            ),
            BlocProvider<DirectionsBloc>(
              create: (context) => DirectionsBloc(
                directionsService: context.read<DirectionsService>(),
              ),
            ),
          ],
          child: DestinationPage(),
        );
        break;

      case Routes.kDestinationDetailPageRoute:
        _page = BlocProvider<DestinationBloc>.value(
          value: settings.arguments as DestinationBloc,
          child: DestinationDetailPage(),
        );
        break;

      case Routes.kRoutePageRoute:
        _page = BlocProvider<DestinationBloc>.value(
          value: settings.arguments as DestinationBloc,
          child: RoutePage(),
        );
        break;

      case Routes.kPlacePageRoute:
        _page = Provider<Place>.value(
          value: settings.arguments as Place,
          child: PlacePage(),
        );
        break;

      case Routes.kItineraryFormPageRoute:
        _page = MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => ItineraryFormBloc(
                itinerary: (settings.arguments as DestinationBloc)
                    .destination
                    .createdItinerary,
              ),
            ),
            BlocProvider<DestinationBloc>.value(
              value: settings.arguments as DestinationBloc,
            )
          ],
          child: ItineraryFormPage(),
        );
        break;

      case Routes.kTrackerPageRoute:
        _page = MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TrackerBloc(
                trackerService: context.read<TrackerService>(),
              ),
            ),
            BlocProvider<DirectionsBloc>(
              create: (context) => DirectionsBloc(
                directionsService: context.read<DirectionsService>(),
              ),
            ),
            BlocProvider<DestinationBloc>.value(
              value: settings.arguments as DestinationBloc,
            )
          ],
          child: TrackerPage(),
        );
        break;

      case Routes.kPhotoViewPageRoute:
        _page = PhotoViewPage(
          args: settings.arguments as PhotoViewPageArgs,
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
