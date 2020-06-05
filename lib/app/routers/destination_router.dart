import 'package:flutter/material.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/blocs/tracker_bloc/tracker_bloc.dart';
import 'package:sahayatri/blocs/directions_bloc/directions_bloc.dart';
import 'package:sahayatri/blocs/itinerary_form_bloc/itinerary_form_bloc.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/itinerary.dart';

import 'package:sahayatri/core/services/tracker_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';

import 'package:sahayatri/ui/shared/animators/page_transition.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';

import 'package:sahayatri/ui/pages/route_page/route_page.dart';
import 'package:sahayatri/ui/pages/place_page/place_page.dart';
import 'package:sahayatri/ui/pages/tracker_page/tracker_page.dart';
import 'package:sahayatri/ui/pages/destination_page/destination_page.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/itinerary_form_page.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/destination_detail_page.dart';

class DestRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget _page;

    switch (settings.name) {
      case '/':
        _page = const DestinationPage();
        break;

      case Routes.kDestinationDetailPageRoute:
        _page = const DestinationDetailPage();
        break;

      case Routes.kRoutePageRoute:
        _page = RoutePage(places: settings.arguments as List<Place>);
        break;

      case Routes.kPlacePageRoute:
        _page = Provider<Place>.value(
          value: settings.arguments as Place,
          child: const PlacePage(),
        );
        break;

      case Routes.kItineraryFormPageRoute:
        _page = BlocProvider(
          create: (_) => ItineraryFormBloc(
            itinerary: settings.arguments as Itinerary,
          ),
          child: const ItineraryFormPage(),
        );
        break;

      case Routes.kTrackerPageRoute:
        _page = MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TrackerBloc(
                trackerService: context.repository<TrackerService>(),
              ),
            ),
            BlocProvider<DirectionsBloc>(
              create: (context) => DirectionsBloc(
                directionsService: context.repository<DirectionsService>(),
              ),
            ),
          ],
          child: const TrackerPage(),
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
