import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:sahayatri/core/constants/routes.dart';
import 'package:sahayatri/core/models/destination.dart';
import 'package:sahayatri/core/models/itinerary.dart';
import 'package:sahayatri/core/models/lodge.dart';
import 'package:sahayatri/core/models/place.dart';

import 'package:sahayatri/cubits/itinerary_cubit/itinerary_cubit.dart';
import 'package:sahayatri/cubits/itinerary_form_cubit/itinerary_form_cubit.dart';
import 'package:sahayatri/cubits/lodge_review_cubit/lodge_review_cubit.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/weather_cubit/weather_cubit.dart';

import 'package:sahayatri/ui/pages/destination_detail_page.dart/destination_detail_page.dart';
import 'package:sahayatri/ui/pages/destination_page/destination_page.dart';
import 'package:sahayatri/ui/pages/itinerary_form_page/itinerary_form_page.dart';
import 'package:sahayatri/ui/pages/itinerary_page/itinerary_page.dart';
import 'package:sahayatri/ui/pages/lodge_page/lodge_page.dart';
import 'package:sahayatri/ui/pages/photo_view_page/photo_view_page.dart';
import 'package:sahayatri/ui/pages/place_page/place_page.dart';
import 'package:sahayatri/ui/pages/route_page/route_page.dart';
import 'package:sahayatri/ui/pages/tracker_page/tracker_page.dart';
import 'package:sahayatri/ui/pages/weather_page/weather_page.dart';
import 'package:sahayatri/ui/widgets/animators/page_transition.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

class DestinationRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget page;

    switch (settings.name) {
      case '/':
        page = const DestinationPage();
        break;

      case Routes.destinationDetailPageRoute:
        page = BlocProvider<ItineraryCubit>(
          lazy: false,
          create: (context) => ItineraryCubit(
            user: context.read<UserCubit>().user,
            destination: context.read<Destination>(),
          )..fetchItineraries(),
          child: const DestinationDetailPage(),
        );
        break;

      case Routes.routePageRoute:
        page = const RoutePage();
        break;

      case Routes.placePageRoute:
        page = Provider<Place>.value(
          value: settings.arguments as Place,
          child: const PlacePage(),
        );
        break;

      case Routes.lodgePageRoute:
        page = Provider<Lodge>.value(
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
        page = Provider<Itinerary>.value(
          value: settings.arguments as Itinerary,
          child: const ItineraryPage(),
        );
        break;

      case Routes.itineraryFormPageRoute:
        page = BlocProvider<ItineraryFormCubit>(
          create: (_) => ItineraryFormCubit(
            itinerary: settings.arguments as Itinerary,
          ),
          child: ItineraryFormPage(),
        );
        break;

      case Routes.trackerPageRoute:
        page = const TrackerPage();
        break;

      case Routes.weatherPageRoute:
        final weatherPageArgs = settings.arguments as WeatherPageArgs;
        page = BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(
            title: weatherPageArgs.name,
          )..fetchWeather(weatherPageArgs.coord),
          child: const WeatherPage(),
        );
        break;

      case Routes.photoViewPageRoute:
        page = PhotoViewPage(args: settings.arguments as PhotoViewPageArgs);
        break;

      default:
        page = Scaffold(
          appBar: AppBar(),
          body: Center(
            child: ErrorIndicator(
              message: 'No route defined for\n${settings.name}',
            ),
          ),
        );
        break;
    }

    return PageTransition(page: page);
  }
}
