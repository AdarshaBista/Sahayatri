import 'package:flutter/material.dart';

import 'package:sahayatri/locator.dart';

import 'package:sahayatri/core/services/navigation_service.dart';

import 'package:sahayatri/app/constants/configs.dart';
import 'package:sahayatri/app/routers/root_router.dart';

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
    return FutureBuilder(
      future: BlocProvider.of<UserCubit>(context).checkUserLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
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
          return _buildApp(false);
        }
        return MultiBlocProvider(
          providers: [
            BlocProvider<NearbyCubit>(create: (context) => NearbyCubit()),
            BlocProvider<TranslateCubit>(create: (context) => TranslateCubit()),
          ],
          child: _buildApp(true),
        );
      },
    );
  }

  Widget _buildApp(bool isLoggedIn) {
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
          home: isLoggedIn ? _buildPrefsState(context) : const AuthPage(),
        );
      },
    );
  }

  Widget _buildPrefsState(BuildContext context) {
    return BlocBuilder<PrefsCubit, PrefsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SplashView();
        }
        return const HomePage();
      },
    );
  }
}
