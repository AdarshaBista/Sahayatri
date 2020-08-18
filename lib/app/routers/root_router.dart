import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/core/services/api_service.dart';
import 'package:sahayatri/core/services/directions_service.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/directions_cubit/directions_cubit.dart';
import 'package:sahayatri/cubits/destination_cubit/destination_cubit.dart';
import 'package:sahayatri/cubits/destination_review_cubit/destination_review_cubit.dart';

import 'package:sahayatri/ui/shared/animators/page_transition.dart';
import 'package:sahayatri/ui/shared/indicators/error_indicator.dart';

import 'package:sahayatri/ui/pages/auth_page/auth_page.dart';
import 'package:sahayatri/ui/pages/home_page/home_page.dart';
import 'package:sahayatri/ui/pages/destination_page/destination_nav_page.dart';

class RootRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget _page;

    switch (settings.name) {
      case Routes.kAuthPageRoute:
        if (settings.arguments != null) {
          _page = AuthPage(isInitial: settings.arguments as bool);
        } else {
          _page = const AuthPage();
        }
        break;

      case Routes.kHomePageRoute:
        _page = const HomePage();
        break;

      case Routes.kDestinationPageRoute:
        _page = MultiBlocProvider(
          providers: [
            BlocProvider<DestinationCubit>(
              create: (context) => DestinationCubit(
                destination: settings.arguments as Destination,
              ),
            ),
            BlocProvider<DestinationReviewCubit>(
              create: (context) => DestinationReviewCubit(
                apiService: context.repository<ApiService>(),
                destination: settings.arguments as Destination,
              )..fetchReviews(),
            ),
            BlocProvider<DirectionsCubit>(
              create: (context) => DirectionsCubit(
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
