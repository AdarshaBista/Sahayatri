import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/models/user.dart';
import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/routers/root_router.dart';

import 'package:sahayatri/app/database/prefs_dao.dart';
import 'package:sahayatri/app/database/tracker_dao.dart';
import 'package:sahayatri/app/database/itinerary_dao.dart';
import 'package:sahayatri/app/database/destination_dao.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:device_preview/device_preview.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/common/splash_view.dart';

import 'package:sahayatri/ui/pages/auth_page/auth_page.dart';
import 'package:sahayatri/ui/pages/home_page/home_page.dart';

class Sahayatri extends StatelessWidget {
  const Sahayatri();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider<PrefsCubit>(create: (context) => PrefsCubit()),
        BlocProvider<NearbyCubit>(create: (context) => NearbyCubit()),
        BlocProvider<TranslateCubit>(create: (context) => TranslateCubit()),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            onAuthenticated: (user) => onAuthenticated(context, user),
          )..isLoggedIn(),
        ),
      ],
      child: _buildApp(),
    );
  }

  Widget _buildApp() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          title: AppConfig.appName,
          builder: DevicePreview.appBuilder,
          locale: DevicePreview.locale(context),
          onGenerateRoute: RootRouter.onGenerateRoute,
          navigatorKey: locator<RootNavService>().navigatorKey,
          home: _buildUserState(),
        );
      },
    );
  }

  Widget _buildUserState() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return _buildPrefsState(context, state);
        } else if (state is AuthLoading) {
          return const SplashView();
        } else {
          return const AuthPage();
        }
      },
    );
  }

  Widget _buildPrefsState(BuildContext context, Authenticated state) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SplashView();
        }
        return const HomePage();
      },
    );
  }

  void onAuthenticated(BuildContext context, User user) {
    getApplicationDocumentsDirectory().then((appDir) {
      final hivePath = '${appDir.path}/${AppConfig.appName}';
      final userDirectoryPath = '$hivePath/${user.id}';
      Directory(userDirectoryPath).createSync();
    });

    locator<PrefsDao>().init(user.id);
    locator<TrackerDao>().init(user.id);
    locator<ItineraryDao>().init(user.id);
    locator<DestinationDao>().init(user.id);

    final prefsCubit = BlocProvider.of<PrefsCubit>(context);
    prefsCubit.init().then((_) {
      final prefs = prefsCubit.prefs;
      BlocProvider.of<ThemeCubit>(context).init(prefs.theme);
    });
  }
}
