import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/place.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';
import 'package:sahayatri/cubits/weather_cubit/weather_cubit.dart';
import 'package:sahayatri/cubits/itinerary_cubit/itinerary_cubit.dart';
import 'package:sahayatri/cubits/lodge_review_cubit/lodge_review_cubit.dart';
import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';

import 'package:sahayatri/ui/widgets/animators/page_transition.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

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

      case Routes.destinationDetailPageRoute:
        _page = BlocProvider<ItineraryCubit>(
          lazy: false,
          create: (context) => ItineraryCubit(
            user: context.read<UserCubit>().user,
            destination: context.read<Destination>(),
          )..fetchItineraries(),
          child: const DestinationDetailPage(),
        );
        break;

      case Routes.routePageRoute:
        _page = const RoutePage();
        break;

      case Routes.placePageRoute:
        _page = Provider<Place>.value(
          value: settings.arguments as Place,
          child: const PlacePage(),
        );
        break;

      case Routes.lodgePageRoute:
        _page = Provider<Lodge>.value(
          value: settings.arguments as Lodge,
          child: BlocProvider<ReviewCubit>(
            create: (context) => LodgeReviewCubit(
              lodge: settings.arguments as Lodge,
              user: context.read<UserCubit>().user,
            )..fetchReviews(),
            child: const LodgePage(),
          ),
        );
        break;

      case Routes.itineraryPageRoute:
        _page = Provider<Itinerary>.value(
          value: settings.arguments as Itinerary,
          child: const ItineraryPage(),
        );
        break;

      case Routes.itineraryFormPageRoute:
        _page = BlocProvider<ItineraryFormCubit>(
          create: (_) => ItineraryFormCubit(
            itinerary: settings.arguments as Itinerary,
          ),
          child: ItineraryFormPage(),
        );
        break;

      case Routes.trackerPageRoute:
        _page = const TrackerPage();
        break;

      case Routes.weatherPageRoute:
        final weatherPageArgs = settings.arguments as WeatherPageArgs;
        _page = BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(
            title: weatherPageArgs.name,
          )..fetchWeather(weatherPageArgs.coord),
          child: const WeatherPage(),
        );
        break;

      case Routes.photoViewPageRoute:
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
