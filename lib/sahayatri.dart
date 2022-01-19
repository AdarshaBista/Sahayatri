import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/constants/configs.dart';
import 'package:sahayatri/core/services/navigation_service.dart';
import 'package:sahayatri/core/services/location/location_service.dart';

import 'package:sahayatri/app/routers/root_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahayatri/cubits/user_cubit/user_cubit.dart';
import 'package:sahayatri/cubits/prefs_cubit/prefs_cubit.dart';
import 'package:sahayatri/cubits/theme_cubit/theme_cubit.dart';
import 'package:sahayatri/cubits/nearby_cubit/nearby_cubit.dart';
import 'package:sahayatri/cubits/tracker_cubit/tracker_cubit.dart';
import 'package:sahayatri/cubits/translate_cubit/translate_cubit.dart';

import 'package:device_preview/device_preview.dart';
import 'package:sahayatri/ui/styles/styles.dart';
import 'package:sahayatri/ui/widgets/views/splash_view.dart';

import 'package:sahayatri/ui/pages/auth_page/auth_page.dart';
import 'package:sahayatri/ui/pages/home_page/home_page.dart';

class Sahayatri extends StatelessWidget {
  const Sahayatri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlocProvider.of<UserCubit>(context).isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildUserState(context);
        }
        return const SplashView();
      },
    );
  }

  Widget _buildUserState(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          return _buildApp(const AuthPage());
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider<NearbyCubit>(create: (context) => NearbyCubit()),
            BlocProvider<TrackerCubit>(create: (context) => TrackerCubit()),
            BlocProvider<TranslateCubit>(create: (context) => TranslateCubit()),
          ],
          child: _buildApp(_buildPrefsState(context)),
        );
      },
    );
  }

  Widget _buildPrefsState(BuildContext context) {
    return BlocConsumer<PrefsCubit, PrefsState>(
      listener: (context, state) {
        if (!state.isLoading) {
          if (locator.isRegistered<LocationService>() &&
              locator.isRegistered<LocationService>(instanceName: 'mock')) {
            final gpsAccuracy = state.prefs.gpsAccuracy;
            locator<LocationService>().setLocationAccuracy(gpsAccuracy);
            locator<LocationService>(instanceName: 'mock')
                .setLocationAccuracy(gpsAccuracy);
          }
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const SplashView();
        }
        return const HomePage();
      },
    );
  }

  Widget _buildApp(Widget home) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Listener(
          onPointerDown: (_) => _unfocusKeyboard(context),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            title: AppConfig.appName,
            builder: DevicePreview.appBuilder,
            locale: DevicePreview.locale(context),
            onGenerateRoute: RootRouter.onGenerateRoute,
            navigatorKey: locator<RootNavService>().navigatorKey,
            home: home,
          ),
        );
      },
    );
  }

  void _unfocusKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
