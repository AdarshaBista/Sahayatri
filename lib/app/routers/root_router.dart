import 'package:flutter/material.dart';

import 'package:sahayatri/core/models/destination.dart';

import 'package:sahayatri/app/constants/routes.dart';

import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/review_cubit/review_cubit.dart';
import 'package:sahayatri/cubits/directions_cubit/directions_cubit.dart';
import 'package:sahayatri/cubits/destination_review_cubit/destination_review_cubit.dart';
import 'package:sahayatri/cubits/destination_update_cubit/destination_update_cubit.dart';

import 'package:sahayatri/ui/widgets/animators/page_transition.dart';
import 'package:sahayatri/ui/widgets/indicators/error_indicator.dart';

import 'package:sahayatri/ui/pages/auth_page/auth_page.dart';
import 'package:sahayatri/ui/pages/home_page/home_page.dart';
import 'package:sahayatri/ui/pages/destination_page/destination_nav_page.dart';

class RootRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget _page;

    switch (settings.name) {
      case Routes.authPageRoute:
        if (settings.arguments != null) {
          _page = AuthPage(isInitial: settings.arguments as bool);
        } else {
          _page = const AuthPage();
        }
        break;

      case Routes.homePageRoute:
        _page = const HomePage();
        break;

      case Routes.destinationPageRoute:
        _page = MultiBlocProvider(
          providers: [
            BlocProvider<ReviewCubit>(
              create: (context) => DestinationReviewCubit(
                user: context.read<UserCubit>().user,
                destination: settings.arguments as Destination,
              )..fetchReviews(),
            ),
            BlocProvider<DestinationUpdateCubit>(
              create: (context) => DestinationUpdateCubit(
                user: context.read<UserCubit>().user,
                destination: settings.arguments as Destination,
              )..fetchUpdates(),
            ),
            BlocProvider<DirectionsCubit>(
              create: (context) => DirectionsCubit(),
            ),
          ],
          child: Provider<Destination>(
            create: (_) => settings.arguments as Destination,
            child: const DestinationNavPage(),
          ),
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
