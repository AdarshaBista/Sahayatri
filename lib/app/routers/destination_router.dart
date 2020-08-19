import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/sms_service.dart';
import 'package:sahayatri/core/services/nearby_service.dart';
import 'package:sahayatri/core/services/weather_service.dart';
import 'package:sahayatri/core/services/tracker_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';
import 'package:sahayatri/core/services/offroute_alert_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/places_cubit/places_cubit.dart';
import 'package:sahayatri/cubits/weather_cubit/weather_cubit.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';
import 'package:sahayatri/cubits/itinerary_cubit/itinerary_cubit.dart';
import 'package:sahayatri/cubits/directions_cubit/directions_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';
import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:sahayatri/ui/shared/animators/page_transition.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';

import 'package:sahayatri/ui/pages/route_page/route_page.dart';
import 'package:sahayatri/ui/pages/place_page/place_page.dart';
import 'package:sahayatri/ui/pages/lodge_page/lodge_page.dart';
import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';
import 'package:sahayatri/ui/pages/tracker_page/tracker_page.dart';
import 'package:sahayatri/ui/pages/itinerary_page/itinerary_page.dart';
import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';
import 'package:sahayatri/ui/pages/destination_page/destination_page.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/itinerary_form_page.dart';
import 'package:sahayatri/ui/pages/destination_detail_page.dart/destination_detail_page.dart';

class DestinationRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget _page;

    switch (settings.name) {
      case '/':
        _page = const DestinationPage();
        break;

      case Routes.kDestinationDetailPageRoute:
        _page = MultiBlocProvider(
          providers: [
            BlocProvider<PlacesCubit>(
              create: (context) => PlacesCubit(
                user: context.bloc<UserCubit>().user,
                apiService: context.repository<ApiService>(),
                destination: context.bloc<DestinationCubit>().destination,
              )..fetchPlaces(),
            ),
            BlocProvider<ItineraryCubit>(
              create: (context) => ItineraryCubit(
                user: context.bloc<UserCubit>().user,
                apiService: context.repository<ApiService>(),
                destination: context.bloc<DestinationCubit>().destination,
              )..fetchItineraries(),
            ),
          ],
          child: const DestinationDetailPage(),
        );
        break;

      case Routes.kRoutePageRoute:
        _page = const RoutePage();
        break;

      case Routes.kPlacePageRoute:
        _page = Provider<Place>.value(
          value: settings.arguments as Place,
          child: const PlacePage(),
        );
        break;

      case Routes.kLodgePageRoute:
        _page = Provider<Lodge>.value(
          value: settings.arguments as Lodge,
          child: const LodgePage(),
        );
        break;

      case Routes.kItineraryPageRoute:
        _page = Provider<Itinerary>.value(
          value: settings.arguments as Itinerary,
          child: const ItineraryPage(),
        );
        break;

      case Routes.kItineraryFormPageRoute:
        _page = BlocProvider<ItineraryFormCubit>(
          create: (_) => ItineraryFormCubit(
            itinerary: settings.arguments as Itinerary,
          ),
          child: ItineraryFormPage(),
        );
        break;

      case Routes.kTrackerPageRoute:
        _page = MultiBlocProvider(
          providers: [
            BlocProvider<TrackerCubit>(
              create: (context) => TrackerCubit(
                smsService: context.repository<SmsService>(),
                nearbyService: context.repository<NearbyService>(),
                trackerService: context.repository<TrackerService>(),
                offRouteAlertService: context.repository<OffRouteAlertService>(),
              )..attemptTracking(settings.arguments as Destination),
            ),
            BlocProvider<DirectionsCubit>(
              create: (context) => DirectionsCubit(
                directionsService: context.repository<DirectionsService>(),
              ),
            ),
          ],
          child: const TrackerPage(),
        );
        break;

      case Routes.kWeatherPageRoute:
        final weatherPageArgs = settings.arguments as WeatherPageArgs;
        _page = BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(
            title: weatherPageArgs.name,
            weatherService: context.repository<WeatherService>(),
          )..fetchWeather(weatherPageArgs.coord),
          child: const WeatherPage(),
        );
        break;

      case Routes.kPhotoViewPageRoute:
        _page = PhotoViewPage(args: settings.arguments as PhotoViewPageArgs);
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
